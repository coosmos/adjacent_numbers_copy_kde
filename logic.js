function generateQuestion() {
    let num1 = Math.floor(Math.random() * 10) + 1; // Random number 1–10
    let num2 = num1+1; // Random number 1–10
    let options = [num1 + num2, num2 + 1, num1*2+1]; // Include correct answer
    options.sort(() => Math.random() - 0.5); // Shuffle options
    return {
        num1: num1,
        num2: num2,
        options: options
    };
}
