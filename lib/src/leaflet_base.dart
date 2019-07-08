// TODO: Put public facing types in this file.

import 'dart:core';
import 'dart:js';

abstract class JsObjectWrapper {

  JsObject _jsObject;

  JsObjectWrapper(this._jsObject);
}

///
/// Layer
/// @see https://leafletjs.com/reference-1.5.0.html#layer
///
class LayerOptions {
  String pane;
  String attribution;
}

class Layer extends JsObjectWrapper {
  Layer(JsObject jsObject) : super(jsObject);

  Layer addTo(Map map) {
    _jsObject.callMethod('addTo', [map._jsObject]);
    return this;
  }
}

///
/// TileLayer
/// @see https://leafletjs.com/reference-1.5.0.html#tilelayer
///
class TileLayer extends Layer {

  TileLayer(JsObject jsObject) : super(jsObject);
}

class TileLayerOptions extends LayerOptions {
  int minZoom;
  int maxZoom;
  List<String> subdomains = ['abc'];
  String errorTileUrl = '';
  int zoomOffset;
  bool tms;
  bool zoomReverse;
  bool detectRetina;
  bool crossOrigin;

  JsObject toJsObject() {
    return JsObject.jsify({
      "minZoom": minZoom,
      "maxZoom": maxZoom,
      "subdomains": subdomains,
      "errorTileUrl": errorTileUrl,
      "zoomOffset": zoomOffset,
      "tms": tms,
      "zoomReverse": zoomReverse,
      "detectRetina": detectRetina,
      "crossOrigin": crossOrigin
    });
  }
}

class LatLng extends JsObjectWrapper {
  LatLng(JsObject jsObject) : super(jsObject);
}

class Map extends JsObjectWrapper {
  Map(JsObject jsObject) : super(jsObject);

  Map setView(LatLng latLng, int zoom) {
    _jsObject.callMethod('setView', [latLng._jsObject, zoom]);
    return this;
  }
}

Map map(String id) {
  JsObject jsObject = context['L'].callMethod('map', [id]);
  return Map(jsObject);
}

LatLng latLng(double latitude, double longitude) {
  return LatLng(context['L'].callMethod('latLng', [latitude, longitude]));
}

TileLayer tileLayer(String urlTemplate, {TileLayerOptions options}) {
  List args = [urlTemplate];
  if (options != null) {
    args.add(options.toJsObject());
  }
  return TileLayer(context['L'].callMethod('tileLayer', args));
}
