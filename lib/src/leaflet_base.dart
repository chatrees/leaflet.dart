// TODO: Put public facing types in this file.

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

///
/// TileLayer
/// @see https://leafletjs.com/reference-1.5.0.html#tilelayer
///
class TileLayer extends JsObjectWrapper {
  TileLayer(JsObject jsObject) : super(jsObject);
}

class TileLayerOptions extends LayerOptions {
  int minZoom;
}

class LatLng extends JsObjectWrapper {
  LatLng(JsObject jsObject) : super(jsObject);
}

class Map extends JsObjectWrapper {
  Map(JsObject jsObject) : super(jsObject);

  void setView(LatLng latLng, int zoom) {
    _jsObject.callMethod('setView', [latLng._jsObject, zoom]);
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
  return TileLayer(context['L'].callMethod('tileLayer', [urlTemplate]));
}
