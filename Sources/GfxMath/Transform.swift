public enum DTransform2 {
  case translate(DVec2)
  case scale(DVec2, origin: DVec2? = nil)

  public func transform(point: DVec2) -> DVec2 {
    switch self {
    case let .translate(translation):
      return point + translation
    case let .scale(scale, origin):
      var result = point
      if let origin = origin {
        result -= origin
      }
      result *= scale
      if let origin = origin {
        result += origin
      }
      return result
    }
  }
}

extension Array where Element == DTransform2 {
  public func transform(point: DVec2) -> DVec2 {
    var result = point
    for transform in self {
      result = transform.transform(point: result)
    }
    return result
  }

  public func transform(rect: DRect) -> DRect {
    DRect(min: transform(point: rect.min), max: transform(point: rect.max))
  }
}