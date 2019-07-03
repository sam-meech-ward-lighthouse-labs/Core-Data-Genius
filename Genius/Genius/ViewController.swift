//
//  ViewController.swift
//  Genius
//
//  Created by Sam Meech-Ward on 2019-07-03.
//  Copyright © 2019 meech-ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let dataManager = DataManager.shared

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    loadObjects()
    
  }
  
  func loadObjects() {
    let quizzes = try! dataManager.getQuizzes()
    
//    quizzes[0].questions!.anyObject() as! Question
    print(quizzes)
    quizzes[0].title = "This is the only quiz"
    
//    dataManager.viewContext.delete(quizzes[0])
    
    
//    dataManager.viewContext.undo()
    
//    dataManager.saveContext()
    
  }
  
  func createObjects() {
    
    let question1 = Question(context: dataManager.viewContext)
    question1.text = "Why is the sky blue?"
    
    let question2 = Question(context: dataManager.viewContext)
    question2.text = "What does MVC Stand For?"
    
    let quiz = Quiz(context: dataManager.viewContext)
    quiz.addToQuestions(question1)
    quiz.addToQuestions(question2)
  }
  
  func createObjectsInBackground() {
    
    let question1 = Question(context: dataManager.backgroundContext)
    question1.text = "Why is the sky blue?"
    
    let question2 = Question(context: dataManager.backgroundContext)
    question2.text = "What does MVC Stand For?"
    
    let quiz = Quiz(context: dataManager.backgroundContext)
    quiz.addToQuestions(question1)
    quiz.addToQuestions(question2)
    
    try! dataManager.backgroundContext.save()
  }
}

