function sleep_3s() {
    setTimeout(() => console.log('Wake up!'), 3000)    
}

function first(){
    console.log('first')
}

function second(){
    console.log('second')
}

function third(){
    console.log('third')
}

first()
setTimeout(second(), 1000)
third()


// console.log('Start Sleeping')
// sleep_3s()
// console.log('End of Program!')