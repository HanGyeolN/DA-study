const numbersEach = (numbers, callback) => {
    let acc = 0 // accumulator
    for (const number of numbers) {
        acc = callback(number, acc) // [???]한다 === callback
    }

    return acc
}

// 더하기
const addEach = (number, acc) => {
    return acc + number 
}

// 빼기
const subEach = (number, acc) => {
    return acc - number
}

// 곱하기
const mulEach = (number, acc) => {
    return acc * number
}

const NUMBERS = [1,2,3,4,5]

console.log(numbersEach(NUMBERS, addEach))