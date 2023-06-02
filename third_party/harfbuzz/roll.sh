#!/bin/bash

HB_GIT_DIR=third_party/externals/harfbuzz
HB_BUILD_DIR=$(dirname -- "$0")


check_all_files_are_categorized() {
  #for each file name in ${HB_GIT_DIR}/src/hb-*.{cc,h,hh}
  #  if the file name is not present in BUILD.gn
  #    should be added to BUILD.gn (in 'unused_sources' if unwanted)

  #for each file name \"src/.*\" in BUILD.gn
  #  if the file name does not exist
  #    should be removed from BUILD.gn

  STEP="Updating BUILD.gn" &&
  HB_BUILD_DIR_REL=$(realpath --relative-to=${HB_GIT_DIR} ${HB_BUILD_DIR})
  ( # Create subshell for IFS, CDPATH, and cd.
    # This implementation doesn't handle '"' or '\n' in file names.
    IFS=$'\n' &&
    CDPATH= &&
    cd -- "${HB_GIT_DIR}" &&

    HB_SOURCE_MISSING=false &&
    find src -type f \( -name "*.cc" -o -name "*.h" -o -name "*.hh" \) | while read HB_SOURCE
    do
      if ! grep -qF "$HB_SOURCE" ${HB_BUILD_DIR_REL}/BUILD.gn; then
        if ! ${HB_SOURCE_MISSING}; then
          echo "Is in src/*.{cc,h,hh} but not in BUILD.gn:"
          HB_SOURCE_MISSING=true
        fi
        echo "      \"\$_${HB_SOURCE}\","
      fi
    done &&

    GN_SOURCE_MISSING=false &&
    grep -oE "\"\\\$_src/[^\"]+\"" ${HB_BUILD_DIR_REL}/BUILD.gn | sed 's/^...\(.*\).$/\1/' | while read GN_SOURCE
    do
      if [ ! -f "${GN_SOURCE}" ]; then
        if ! ${GN_SOURCE_MISSING}; then
          echo "Is referenced in BUILD.gn but does not exist:" &&
          GN_SOURCE_MISSING=true
        fi
        echo "\"${GN_SOURCE}\""
      fi
    done &&

    GN_SOURCE_DUPLICATES=$(sort ${HB_BUILD_DIR_REL}/BUILD.gn | uniq -d | grep -oE "\"\\\$_src/[^\"]+\"")
    if [ ! -z ${GN_SOURCE_DUPLICATES} ]; then
      echo "Is listed more than once in BUILD.gn:" &&
      echo ${GN_SOURCE_DUPLICATES}
    fi
  )
}

check_all_files_are_categorized 
true || { echo "Failed step ${STEP}"; exit 1; }