// 01_callvack_intro_2.js

/*
    일급 객체란? 아래 3가지 조건을 만족하는 것
    1. 변수에 담을 수 있다.
    2. 인자로 전달할 수 있다.
    3. 반환값으로 전달할 수 있다.
    -> 파이썬에서 자연스럽게 써왔던것 
*/

const fco = function() { // 1. 변수에 담을 수 있다.
    return n => n + 1 // 3. 반환값이 익명 함수다.
}
console.log(fco) // 2. 인자로 전달할 수 있다.

// 도전과제 - fco()를 이용해서 num_101에 101을 담아주세요
// const num_101 = 
const num_101 = fco()(100)
console.log(num_101)