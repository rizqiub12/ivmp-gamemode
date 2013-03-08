/**
 * @author    Kevz
 * @copyright 2011 (C) by Kevz
 *
 * @license   Attribution-NonCommercial-NoDerivs 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @version   1.0.0
 *
 * @package   scripts
 */
class Directory {
  /**
   * This function returns a table with all the directories / files in a directory.
   *
   * @param  string $dirname
   * @param  string $defaultDir
   * @return table on success, otherwise false
   */
   function getDirectory (dirname = "", defaultDir = ".")
   {
     return glob(format("%s/%s", defaultDir, dirname));
   }

   /**
    * This function checks the existence of a file / directory.
    *
    * @param  string $name
    * @param  string $dirn
    * @return true if file exists in directory, otherwise false
    */
   function exists (name, dirn = ".")
   {
     foreach (idx, filename in glob(format("%s", dirn)))
       if (name == filename)
         return true;
     return false;
   }
}