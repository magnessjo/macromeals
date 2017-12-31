<?php

namespace Calendar\Library\CodePack\Components\FileObject;

use Calendar\Library\CodePack\Exceptions\FileObject\FileObjectException;
use Craft\CalendarPlugin;
use Craft\IOHelper;

class File extends FileObject
{
    /** @var bool */
    protected $folder = false;

    /**
     * File constructor.
     *
     * @param $path
     */
    protected function __construct($path)
    {
        $file = IOHelper::getFile($path);

        $this->path = $path;
        $this->name = $file->getFileName(true);
    }

    /**
     * Copy the file or directory to $target location
     *
     * @param string              $target
     * @param string|null         $prefix
     * @param array|callable|null $callable
     * @param string|null         $filePrefix
     *
     * @return void
     * @throws FileObjectException
     */
    public function copy($target, $prefix = null, $callable = null, $filePrefix = null)
    {
        $target = rtrim($target, '/');
        $newFilePath = $target . '/' . $filePrefix . $this->name;

        $wasSuccessful = IOHelper::copyFile($this->path, $newFilePath, true);

        if (!$wasSuccessful) {
            throw new FileObjectException(
                sprintf(
                    'Permissions denied. Could not write file in "%s".<br><a href="%s">Click here to find out how to resolve this issue.</a>',
                    $this->path,
                    CalendarPlugin::PERMISSIONS_HELP_LINK
                )
            );
        }

        if (is_callable($callable)) {
            call_user_func_array($callable, array($newFilePath, $prefix));
        }
    }
}
