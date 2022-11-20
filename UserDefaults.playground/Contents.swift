import Foundation

// MARK: - UserDefaults

// UserDefaults: 앱을 실행하는 동안 지속적으로 키-값 쌍을 저장하는 사용자의 기본 데이터베이스에 대한 인터페이스

// 런타임 시 객체를 사용하여 앱이 사용자의 기본 데이터베이스에서 사용하는 기본값을 읽기 때문에
// 값을 읽어올 때마다 데이터베이스를 열 필요가 없다.

// 사용자의 정보, 자동 로그인, 설정 데이터와 같은 대용량이 아닌 단일 데이터를 주로 UserDefaults를 사용하여 저장한다.

// set(_ value:, forKey:) 메소드를 통해 UserDefaults에 데이터를 저장할 수 있다.
// 첫 번째 파라미터에는 value, 두 번째 파라미터에는 key값을 지정해야 한다.
// value의 형식은 String, Int, Dictionary, Object, Bool 등 거의 대부분을 저장할 수 있다.

UserDefaults.standard.set("Test1111", forKey: "test")
print(UserDefaults.standard.string(forKey: "test") ?? "")

// 기존 값이 있는 경우에서 같은 key값에 새로운 value를 넣을 경우, 기존 value가 새로운 value로 대체된다.

UserDefaults.standard.set("Test2222", forKey: "test")
print(UserDefaults.standard.string(forKey: "test") ?? "")

// removeObject(forKey:) 메소드를 통해 UserDefaults의 해당 key값에 있는 데이터를 삭제할 수 있다.
// 해당 key값에 데이터가 존재하지 않을 경우, Bool은 false, Int, Float, Double은 0, 나머지는 nil을 반환한다.
// 따라서, UserDefaults에서 값을 읽어올 경우에는 nil이 될 수 있기 때문에 옵셔널 바인딩을 해주는 것이 좋다.

UserDefaults.standard.removeObject(forKey: "test")
print(UserDefaults.standard.string(forKey: "test") ?? "")

print(UserDefaults.standard.bool(forKey: "no"))
print(UserDefaults.standard.integer(forKey: "no"))
print(UserDefaults.standard.float(forKey: "no"))
print(UserDefaults.standard.double(forKey: "no"))
print(UserDefaults.standard.object(forKey: "no") ?? "")
print(UserDefaults.standard.dictionary(forKey: "no") ?? "")

// 모델(struct) 저장
// 기본 타입인 Int, String 등은 내부적으로 아카이빙, 언아카이빙을 해주지만 struct는 별도로 해주어야 한다.
// 아카이빙: 객체를 Data형으로 변경하여 메모리, 디스크에 저장 가능한 파일 형식으로 만드는 것
// 언아카이빙: 메모리, 디스크에 저장된 Data형을 struct 객체와 같은 형식으로 만드는 것

// 해당 struct는 필수로 Codable 프로토콜을 준수해야 한다.
// Codable에 대한 내용은 다음에

struct Test: Codable {
    let a: String
    let b: Int
}

let test = Test(a: "test", b: 2)

// struct 객체를 저장하기 위해서는 JSONEncoder 또는 PropertyListEncoder를 이용하여 객체를 아카이빙 해야한다.

UserDefaults.standard.set(try? PropertyListEncoder().encode(test), forKey: "struct")

// struct 객체를 불러오기 위해서는 JSONDecoder 또는 PropertyListDecoder를 이용하여 객체를 언아키이빙 해야한다.
// decode의 타입에는 해당 struct의 이름.self를 지정해주어야 한다.
// struct의 배열일 경우에는 []로 감싸주면 된다.

if let data = UserDefaults.standard.data(forKey: "struct") {
    if let test = try? PropertyListDecoder().decode(Test.self, from: data) {
        print(test)
    }
}

// struct 배열의 경우

let testList = [ Test(a: "a", b: 1),
                 Test(a: "b", b: 2),
                 Test(a: "c", b: 3),
                 Test(a: "d", b: 4)
]

UserDefaults.standard.set(try PropertyListEncoder().encode(testList), forKey: "structList")

if let data = UserDefaults.standard.data(forKey: "structList") {
    let testList = (try? PropertyListDecoder().decode([Test].self, from: data)) ?? []
    
    testList.forEach {
        print($0)
    }
}
