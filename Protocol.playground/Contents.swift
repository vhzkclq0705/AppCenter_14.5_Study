import UIKit


// MARK: 프로토콜 문법(Protocol Syntax)

// 프로토콜의 정의는 class, struct, enum 등과 유사하다.

protocol SomeProtocol {
    // 프로토콜 정의
}

// 프로토콜은 상속이 가능하다.
// 다수의 프로토콜과 서브 클래싱 또한 상속이 가능하다.

protocol AnotherProtocol {}

struct SomeStructure: SomeProtocol, AnotherProtocol {}

class SomeClass: SomeProtocol {}

class SubClass: SomeClass, AnotherProtocol {}

// MARK: - 프로퍼티 요구사항(Property Requirements)

// 프로토콜에서는 프로퍼티가 저장된 프로퍼티인지 계산된 프로퍼티인지 명시하지 않는다.
// 하지만, 프로퍼티의 이름과 타입 그리고 gettable, settable한지는 명시한다.
// 필수 프로퍼티는 항상 var로 선언해야 한다.

protocol PropertyProtocol1 {
    var mustBeSettable: Int { get set }
    var doesNotNeetToBeSettable: Int { get }
}

struct ExampleGetSet: PropertyProtocol1 {
    var temp: Int
    var mustBeSettable: Int {
        get {
            return temp * 2
        }
        set {
            temp += newValue
        }
    }
    var doesNotNeetToBeSettable: Int {
        get {
            return temp + 5
        }
    }
}

var exampleGetSet = ExampleGetSet(temp: 0)
print(exampleGetSet.temp)                       // 0
print(exampleGetSet.mustBeSettable)             // 0
print(exampleGetSet.doesNotNeetToBeSettable)    // 5

exampleGetSet.temp = 5
print(exampleGetSet.temp)                       // 5
print(exampleGetSet.mustBeSettable)             // 10
print(exampleGetSet.doesNotNeetToBeSettable)    // 10

exampleGetSet.mustBeSettable = 10
print(exampleGetSet.temp)                       // 15
print(exampleGetSet.mustBeSettable)             // 30
print(exampleGetSet.doesNotNeetToBeSettable)    // 20

//exampleGetSet.doesNotNeetToBeSettable = 15    // error

// MARK: - 메소드 요구사항 (Method Requirements)

// 프로토콜에서는 필수 인스턴스 메소드와 타입 메소드를 명시할 수 있다.
// 하지만 메소드 파라미터의 기본 값은 프로토콜 안에서 사용할 수 없다.
// 필수 메소드 지정 시 함수명과 반환값을 지정할 수 있고, 구현에 사용하는 괄호는 적지 않아도 된다.

protocol RandomNumberCreater {
    func random() -> [Int]
}

class Lotto: RandomNumberCreater {
    
    let numbers: [Int] = [0, 0, 0, 0, 0, 0]
    
    func random() -> [Int] {
        return numbers.map { _ in
            return Int.random(in: 1...45)
        }
    }
    
}

var lotto = Lotto()
print(lotto.numbers)    // [0, 0, 0, 0, 0, 0]
print(lotto.random())   // [1과 45사이의 정수 6개]

// MARK: - 변경 가능한 메소드 요구사항 (Mutating Method Requirements)

// mutating 키워드를 사용해 인스턴스에서 변경 가능하다는 것을 표시할 수 있다.
// mutating 키워드는 값 타입 형에만 사용이 가능하다.
// 프로토콜에 mutating을 명시한 경우, 이 프로토콜을 따르는 클래스 형을 구현할 때는
// 메소드에 mutating을 명시하지 않아도 된다.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case on, off
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var switchExample = OnOffSwitch.on
print(switchExample)    // on

switchExample.toggle()
print(switchExample)    // off

class ClassWithTogglable: Togglable {
    func toggle() {
        // 클래스는 mutating 키워드를 명시하지 않아도 된다.
    }
}

// MARK: - 초기자 요구사항 (Initializer Requirements)

// 프로토콜에서 필수로 구현해야하는 이니셜라이저를 지정할 수 있다.

protocol InitializerProtocol1 {
    init(someParameter: Int)
}

// 클래스에서 프로토콜 필수 이니셜라이저의 구현

// 프로콜에서 특정 이니셜라이저가 필요하다고 명시했기 때문에
// 구현에서 해당 이니셜라이저에 required 키워드를 붙여줘야 한다.

class InitalizerClass1: InitializerProtocol1 {
    required init(someParameter: Int) {
        // 이니셜라이저 구현
    }
}

// 클래스 타입에서 final로 선언된 것에는 required를 표시하지 않아도 된다.
// final로 선언되면 서브클래싱이 불가능하기 때문이다.

final class InitalizerClass2: InitializerProtocol1 {
    init(someParameter: Int) {
        // 이니셜라이저 구현
    }
}

// 특정 프로토콜의 필수 이니셜라이저를 구현하고 슈퍼클래스의 이니셜라이저를 서브클래싱하는 경우,
// 이니셜라이저 앞에 required 키워드와 override 키워드를 붙여줘야 한다.

protocol InitializerProtocol2 {
    init()
}

class InitializerSuperClass {
    init() {
        print("슈퍼클래스 이니셜라이저")
    }
}

class InitializerSubClass: InitializerSuperClass, InitializerProtocol2 {
    required override init() {
        print("서브클래스 이니셜라이저")
    }
}

var initializerClass = InitializerSubClass()

