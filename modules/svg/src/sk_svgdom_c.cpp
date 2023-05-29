#include "include/svg/SkSVGCanvas.h"
#include "modules/svg/include/SkSVGDOM.h"
#include "modules/svg/include/SkSVGNode.h"
#include "include/c/sk_svg.h"
#include "modules/svg/include/sk_svgdom_c.h"
#include "src/c/sk_types_priv.h"

void sk_svgdom_render(sk_svgdom_t *svgdom, sk_canvas_t *canvas) {
    reinterpret_cast<SkSVGDOM*>(svgdom)->render(AsCanvas(canvas));
}

void sk_svgdom_set_container_size(sk_svgdom_t *svgdom, float width, float height) {
    reinterpret_cast<SkSVGDOM*>(svgdom)->setContainerSize(SkSize::Make(width, height));
}

float sk_svgdom_get_container_width(sk_svgdom_t *svgdom) {
    return reinterpret_cast<SkSVGDOM*>(svgdom)->containerSize().width();
}

float sk_svgdom_get_container_height(sk_svgdom_t *svgdom) {
    return reinterpret_cast<SkSVGDOM*>(svgdom)->containerSize().height();
}

sk_svgdom_t *sk_svgdom_create_from_stream(sk_stream_t *stream) {
    return reinterpret_cast<sk_svgdom_t*>(SkSVGDOM::MakeFromStream(*AsStream(stream)).release());
}

void sk_svgdom_ref(const sk_svgdom_t *svg) {
    SkSafeRef( reinterpret_cast<const SkSVGDOM*>(svg));
}

void sk_svgdom_unref(const sk_svgdom_t *svg) {
    SkSafeUnref( reinterpret_cast<const SkSVGDOM*>(svg));
}