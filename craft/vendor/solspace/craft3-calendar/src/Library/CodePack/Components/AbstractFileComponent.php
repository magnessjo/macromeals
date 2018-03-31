<?php

namespace Solspace\Calendar\Library\CodePack\Components;

use Solspace\Calendar\Library\CodePack\Components\FileObject\FileObject;
use Solspace\Calendar\Library\CodePack\Components\FileObject\Folder;
use Solspace\Calendar\Library\CodePack\Exceptions\CodePackException;

abstract class AbstractFileComponent implements ComponentInterface
{
    /** @var string */
    protected $installDirectory;

    /** @var string */
    protected $targetFilesDirectory;

    /** @var Folder */
    protected $contents;

    /** @var string */
    private $location;

    /**
     * @param string $location - the location of files
     *
     * @throws CodePackException
     */
    final public function __construct(string $location)
    {
        $this->location = $location;
        $this->contents = $this->locateFiles();
    }

    /**
     * @return string
     */
    abstract protected function getInstallDirectory(): string;

    /**
     * @return string
     */
    abstract protected function getTargetFilesDirectory(): string;

    /**
     * If anything must come after /{install_directory}/{prefix}demo/{???}
     * It is returned here
     *
     * @param string $prefix
     *
     * @return string
     */
    protected function getSubInstallDirectory(string $prefix): string
    {
        return '';
    }

    /**
     * Installs the component files into the $installDirectory
     *
     * @param string|null $prefix
     */
    public function install(string $prefix = null)
    {
        $installDirectory = $this->getInstallDirectory();
        $installDirectory = rtrim($installDirectory, '/');
        $installDirectory .= '/' . $prefix . '/';
        $installDirectory .= ltrim($this->getSubInstallDirectory($prefix), '/');

        foreach ($this->contents as $file) {
            $file->copy($installDirectory, $prefix, array($this, 'postFileCopyAction'));
        }
    }

    /**
     * If anything has to be done with a file once it's copied over
     * This method does it
     *
     * @param string      $newFilePath
     * @param string|null $prefix
     */
    public function postFileCopyAction($newFilePath, $prefix = null)
    {
    }

    /**
     * @return FileObject
     */
    public function getContents()
    {
        return $this->contents;
    }

    /**
     * @return FileObject
     * @throws CodePackException
     */
    private function locateFiles()
    {
        $directory = FileObject::createFromPath($this->getFileLocation());

        if (!$directory instanceof Folder) {
            throw new CodePackException('Target directory is not a directory: ' . $this->getFileLocation());
        }

        return $directory;
    }

    /**
     * @return string
     */
    private function getFileLocation()
    {
        return $this->location . '/' . $this->getTargetFilesDirectory();
    }
}
