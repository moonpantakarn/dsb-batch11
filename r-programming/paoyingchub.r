start_game <- function() {
  ## create variable (store data)
  hands <- c("hammer", "scissor", "paper")
  user_score <- 0
  com_score <- 0
  tie <- 0
  rounds <- 0
  
  ## play game 10 rounds (running process)
  while (rounds < 10) {
    user_ans <- tolower(readline("choose paper, scissor, paper : "))
    com_ans <- sample(hands, 1, replace = TRUE)
    print( paste("computer_answer",com_ans) )
    
    if (user_ans == "rock" & com_ans == "paper") {
      com_score <- com_score + 1
      print("lose")
    } else if (user_ans == "paper" & com_ans == "scissor") {
      com_score <- com_score + 1
      print("lose")
    } else if (user_ans == "scissor" & com_ans == "hammer") {
      com_score <- com_score + 1
      print("lose")
    } else if (user_ans == com_ans){
      tie <- tie + 1
      print("tie")
    } else {
      user_score <- user_score + 1
      print("winner winner chicken")
    }
    rounds <- rounds + 1
  }
  ## results
  print("game over")
  print( paste("total played round : ", rounds))
  print( paste("your_score : ", user_score ))
  print( paste("computer_score : " , com_score ))
  print( paste("tie : ", tie))
  if (user_score > com_score) {
    print("congratulations")
  } else if (user_score < com_score) {
    print("try again")
  } else {
    print("it's tie", tie)
  }
} 

