<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m160602_094836_calendar_AddLocalesToAllEvents extends BaseMigration
{
    /**
     * Any migration code in here is wrapped inside of a transaction.
     *
     * @return bool
     */
    public function safeUp()
    {
        $primaryLocale = craft()->i18n->getPrimarySiteLocaleId();
        $localeIds     = craft()->i18n->getEditableLocaleIds();

        foreach ($localeIds as $key => $locale) {
            if ($locale == $primaryLocale) {
                unset($localeIds[$key]);
                break;
            }
        }

        $i18nData = craft()->db
            ->createCommand()
            ->select('ei18n.*')
            ->from('elements_i18n ei18n')
            ->join('calendar_events e', 'ei18n.elementId = e.id')
            ->queryAll();

        $contentData = craft()->db
            ->createCommand()
            ->select('c.*')
            ->from('content c')
            ->join('calendar_events e', 'c.elementId = e.id')
            ->where('c.locale = :locale', array(':locale' => $primaryLocale))
            ->queryAll();

        $contentDataById = array();
        foreach ($contentData as $data) {
            unset($data['locale'], $data['id'], $data['dateCreated'], $data['dateUpdated'], $data['uid']);
            $contentDataById[$data['elementId']] = $data;
        }

        $eventLocales      = array();
        $primaryLocaleData = array();
        foreach ($i18nData as $data) {
            $eventId = $data['elementId'];

            if ($data['locale'] == $primaryLocale) {
                $primaryLocaleData[$eventId] = $data;
            } else {
                if (!isset($eventLocales[$eventId])) {
                    $eventLocales[$eventId] = array();
                }

                $eventLocales[$eventId][] = $data['locale'];
            }
        }

        foreach ($primaryLocaleData as $data) {
            $eventId = $data['elementId'];

            foreach ($localeIds as $locale) {
                if (isset($eventLocales[$eventId]) && in_array($locale, $eventLocales[$eventId])) {
                    continue;
                }

                craft()->db
                    ->createCommand()
                    ->insertAll(
                        'elements_i18n',
                        array(
                            'elementId',
                            'locale',
                            'slug',
                            'enabled',
                        ),
                        array(
                            array(
                                $eventId,
                                $locale,
                                $data['slug'],
                                true,
                            ),
                        )
                    );

                if (isset($contentDataById[$eventId])) {
                    $content = $contentDataById[$eventId];

                    $columns = array_keys($content);
                    $values  = array_values($content);

                    $columns[] = 'locale';
                    $values[]  = $locale;

                    craft()->db->createCommand()->insertAll('content', $columns, array($values));
                }
            }
        }

        return true;
    }
}
