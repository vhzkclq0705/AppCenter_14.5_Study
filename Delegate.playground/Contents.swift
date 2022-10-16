import UIKit

// MARK: - 위임(Delegation)

// delegate는 클래스 혹은 구조체 인스턴스에 특정 행위에 대한 책임을 넘길 수 있게 해주는 디자인 패턴 중 하나이다.
// delegate를 AnyObject로 선언하면 클래스만 이 프로콜을 따를 수 있게 만들 수 있다.

class Student {
    let name: String
    let num: Int
    let major: String
    
    init(name: String, num: Int, major: String) {
        self.name = name
        self.num = num
        self.major = major
    }
}

protocol AppCenter {
    var student: Student { get }
    
    func study()
}

protocol AppCenterDelegate: AnyObject {
    func studyDidStart(_ appCenter: AppCenter)
    func studyDidEnd(_ appCenter: AppCenter)
}

class IOS: AppCenter {
    var student = Student(name: "권오준", num: 201701529, major: "ComputerScience")
    var delegate: AppCenterDelegate?
    
    func study() {
        delegate?.studyDidStart(self)
        print("\(student.name)은 스터디중")
        delegate?.studyDidEnd(self)
    }
}

// iOS는 AppCenter를 따르고 AppCeneterDelegate를 따르는 delegate를 갖는다.
// 스터디를 시작(study()) 했을 때 delegate 내부의 두 함수를 실행한다.
// delegate는 스터디를 진행하는데 반드시 필요한 건 아니라 옵셔널로 정의되어 있다. ex) 스터디를 가장한 회식
// 아래는 실제 AppCenterDelegate를 상속하는 StudyiOS를 구현한 예시이다.

class StudyiOS: AppCenterDelegate {
    var startAt: Int = 7
    
    func studyDidStart(_ appCenter: AppCenter) {
        print("오후 \(startAt)시에 스터디 시작")
    }
    
    func studyDidEnd(_ appCenter: AppCenter) {
        print("오후 \(startAt + 2)시에 스터디 끝")
    }
}

// StudyiOS를 이용해 스터디를 진행한다.
// 스터디와 관련된 작업은 StudyiOS가 위임받아 실행한다.

let studyiOS = StudyiOS()
let iOS = IOS()

iOS.delegate = studyiOS
iOS.study()

