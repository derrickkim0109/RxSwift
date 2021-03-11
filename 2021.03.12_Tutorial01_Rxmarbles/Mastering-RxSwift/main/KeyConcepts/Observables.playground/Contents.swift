//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

// 새로운 Obserable 생성하기

// # 1 - Create 연산자 - Time Method이다. <- RxSwift에서는 이런것들을 연산자라고 부른다.
Observable<Int>.create{(observer) -> Disposable in
    observer.on(.next(0)) // Subscriber로 next event가 0을 전달하는 것.
    observer.onNext(1) // 같은 방식인데 1을 전달.
    
    // Observable 종료
    observer.onCompleted() // 이거 이후에는 다른 이벤트 전달 불가.
    
    // 그런다음 return 해야함
    // Disposables는 메모리 정리에 필요한 객체이다.
    return Disposables.create()
}



// # 2 From 연산자  - 이 연산자는 미리정의된 규칙에 의해서 이벤트를 전달한다.
// from 연산자는 파라미터로 전달한 배열의 요소를 순서대로 방출하고 Complete 이벤트를 전달하는 Observerable을 생성.
Observable.from([0,1])

// Observer가 Observable을 구독하는 시점 : 이벤트가 전달되는 시점이다. 



