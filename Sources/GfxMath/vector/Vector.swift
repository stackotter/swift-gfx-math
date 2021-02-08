import Foundation

public struct Vector<E: Numeric & Hashable>: VectorProtocol {
    
    public typealias Element = E
    
    public var rows: Int
    
    public var cols: Int
    
    public var elements: [Element]
    
    public init() {
        
        self.rows = 0
        
        self.cols = 1
        
        self.elements = [Element](repeating: 0, count: 3)
    }
}





public protocol Vector2Protocol: VectorProtocol {
    var x: Element { get set }
    var y: Element { get set }
}

public extension Vector2Protocol {
    
    @inlinable var x: Element {
        
        get {
            
            return elements[0]
        }
        
        set {
            
            elements[0] = newValue
        }
    }
    
    @inlinable var y: Element {
        
        get {
            
            return elements[1]
        }
        
        set {
            
            elements[1] = newValue
        }
    }
 
    init(_ elements: [Element]) {

        self.init()
        
        self.elements = elements

        if self.elements.count < count {

            self.elements.append(contentsOf: Array(repeating: Element.zero, count: count - self.elements.count))
        }
    }

    init(_ x: Element, _ y: Element) {
        
        self.init([x, y])
    }

    @inlinable func cross(_ other: Self) -> Element {
        
        return self.x * other.y - self.y * other.x
    }
}

public extension Vector2Protocol where Element: BinaryFloatingPoint, Element.RawSignificand: FixedWidthInteger {
    
    @inlinable static var infinity: Self {
        
        Self(Element.infinity, Element.infinity)
    }
    
    @inlinable static func random(in bounds: Rect<Element>) -> Self {
       
        self.init(Element.random(in: bounds.min.x...bounds.max.x), Element.random(in: bounds.min.y...bounds.max.y))
    }
}

public struct Vector2<E: Numeric & Hashable>: Vector2Protocol {
  
    public typealias Element = E
  
    public var rows: Int
   
    public var cols: Int
   
    public var elements: [Element]

    public init() {
        
        self.rows = 2
        
        self.cols = 1
        
        self.elements = [Element](repeating: 0, count: 2)
    }
}

public typealias DVec2 = Vector2<Double>

public typealias FVec2 = Vector2<Float>

public typealias IVec2 = Vector2<Int>




public protocol Vector3Protocol: Vector2Protocol {

}

public extension Vector3Protocol {

    init(_ x: Element, _ y: Element, _ z: Element) {
        
        self.init()
        
        self.elements = [x, y, z]
    }

    @inlinable func cross(_ rhs: Self) -> Self {
        
        let x = self[1] * rhs[2] - self[2] * rhs[1]
        
        let y = self[2] * rhs[0] - self[0] * rhs[2]
        
        let z = self[0] * rhs[1] - self[1] * rhs[0]
        
        return Self([
            x,
            y,
            z
        ])
    }

    @inlinable var x: Element {
       
        get {
       
            return elements[0]
        }
       
        set {
        
            elements[0] = newValue
        }
    }

    @inlinable var y: Element {
        
        get {
            
            return elements[1]
        }
        
        set {
            
            elements[1] = newValue
        }
    }

    @inlinable var z: Element {
        
        get {
            
            return elements[2]
        }
        
        set {
            
            elements[2] = newValue
        }
    }
}

public extension Vector3Protocol where Element: FloatingPointGenericMath {

    /// - Returns 0 to pi (positive only)
    @inlinable func absAngle(to otherVector: Self) -> Element {

        let angle = acos(normalized().dot(otherVector.normalized()))

        return angle
    }
}

public struct Vector3<E: Numeric & Hashable>: Vector3Protocol {

    public typealias Element = E
    
    public var rows: Int = 3
    
    public var cols: Int = 1
    
    public var elements: [Element]

    public init() {

        self.elements = [Element](repeating: 0, count: 3)
    }

    public init(x: Element, y: Element, z: Element) {

        self.elements = [x, y, z]
    }
}

public typealias DVec3 = Vector3<Double>

public typealias IVec3 = Vector3<Int>





public protocol Vector4Protocol: Vector3Protocol {
    
}

public extension Vector4Protocol {
    
    @inlinable var w: Element {
        
        get {
            
            return elements[3]
        }
        
        set {
        
            elements[3] = newValue
        }
    }
}

public struct Vector4<E: Numeric & Hashable>: VectorProtocol {
    
    public typealias Element = E
    
    public var rows: Int
    
    public var cols: Int
    
    public var elements: [Element]
    
  /*  public var x: Element {
        get {
            return elements[0]
        }
        set {
            elements[0] = newValue
        }
    }
    public var y: Element {
        get {
            return elements[1]
        }
        set {
            elements[1] = newValue
        }
    }
    public var z: Element {
        get {
            return elements[2]
        }
        set {
            elements[2] = newValue
        }
    }
    public var w: Element {
       
    }*/

    public init() {
        
        self.rows = 4
        
        self.cols = 1
        
        self.elements = [Element](repeating: 0, count: 4)
    }

    public init(_ elements: [Element]) {
        
        self.rows = 4
        
        self.cols = 1
        
        self.elements = elements
    }

    public init(_ vec3: Vector3<E>, _ element: Element) {
        
        self.rows = 4
        
        self.cols = 1
        
        self.elements = vec3.elements + [element]
    }

    public init(_ x: Element, _ y: Element, _ z: Element, _ w: Element) {
        
        self.init([x, y, z, w])
    }
}

extension Matrix4Protocol {

    @inlinable public static func matmul <VectorProtocol: Vector4Protocol> (_ other: VectorProtocol) -> VectorProtocol where Self.Element == VectorProtocol.Element {

        return VectorProtocol(try! self.matmul(other).elements)
    }
}

public typealias DVec4 = Vector4<Double>

public typealias FVec4 = Vector4<Float>