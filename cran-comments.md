## Resubmission
This is a resubmission. In this version I have:

* Removed the default writing to the home directory for `set_felt_key()`. If interactive and no path is included, it suggests a default path, but doesn't write unless interactively accepted.

* For consistency, a path argument is added to `felt_get_map_sf()`, which defaults to the temp directory.

## Test environments
* local R installation (Windows 11), R 4.3.1
* local R installation (macOS), R 4.3.0
* ubuntu 20.04 (on GitHub Actions), (devel and release)
* windows-latest (on GitHub Actions), (release)
* macOS-latest (on GitHub Actions), (release)
* Windows (on Winbuilder), (devel)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Additional notes

* There is not a corresponding paper to cite in the description.
