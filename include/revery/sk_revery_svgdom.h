#ifndef sk_revery_svg_DEFINED
#define sk_revery_svg_DEFINED

#include "include/c/sk_types.h"
SK_C_PLUS_PLUS_BEGIN_GUARD

SK_C_API void sk_revery_svgdom_render(sk_svgdom_t *svgdom, sk_canvas_t *canvas);
SK_C_API void sk_revery_svgdom_set_container_size(sk_svgdom_t *svgdom, float width, float height);
SK_C_API float sk_revery_svgdom_get_container_width(sk_svgdom_t *svgdom);
SK_C_API float sk_revery_svgdom_get_container_height(sk_svgdom_t *svgdom);
SK_C_API sk_svgdom_t *sk_revery_create_from_stream(sk_stream_t *stream);
SK_C_API void sk_revery_svgdom_ref(const sk_svgdom_t *svg);
SK_C_API void sk_revery_svgdom_unref(const sk_svgdom_t *svg);

SK_C_PLUS_PLUS_END_GUARD
#endif