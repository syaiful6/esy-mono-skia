#!/usr/bin/env bash

generate_patch() {
  base_commit=$1
  files=$2
  output=$3

  git diff $base_commit -- $files > $output
}

# SVG patch
svg_base_commit="91c98f63fbb6365fba96b4141faa2d135c818dd9"
svg_files="include/c/sk_svg.h include/c/sk_types.h src/c/sk_svg.cpp src/c/sk_types_priv.h"
svg_output="./patches/svg-c-bindings.patch"
generate_patch "$svg_base_commit" "$svg_files" "$svg_output"

# BUILD.gn patch
build_gn_base_commit="91c98f63fbb6365fba96b4141faa2d135c818dd9"
build_gn_files="BUILD.gn"
build_gn_output="./patches/build-svg.patch"
generate_patch "$build_gn_base_commit" "$build_gn_files" "$build_gn_output"

# Expose SVGDOM patch
expose_svgdom_base_commit="91c98f63fbb6365fba96b4141faa2d135c818dd9"
expose_svgdom_files="experimental/svg/model/SkSVGDOM.h"
expose_svgdom_output="./patches/expose-svgdom.patch"
generate_patch "$expose_svgdom_base_commit" "$expose_svgdom_files" "$expose_svgdom_output"
