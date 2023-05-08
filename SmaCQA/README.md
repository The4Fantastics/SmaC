**SmaCQA Tool**
================
SmaCQA is a textual DSL developed using the Xtext tool incorporated into the Sirius framework. SmaCQA arises due to the limitation of the e3value notation to represent the circumstances in which value exchanges take place between the actors that are part of the model presented in this notation. This limitation makes it difficult to establish a useful technological bridge using MDE to extract, from an e3value model, its corresponding smart contract model. Therefore, the purpose of SmaCQA is to act as support during the model transformation process, supporting the information specified by the user regarding the temporal and economic context for each value exchange between actors.

**SmaCQA Tool Display**
_______________

![SmaCQA tool display](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Videos/SmaCly_Introduction.gif)

**ScreenCast**
_______________

![SmaCQA tool](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/energycase_smacqa_iteration3.PNG)


**SmaCQA Metamodel View**
_______________________

![SmaCQA tool](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/smacqametamodel.png)
_______________

**Create SmaCQA model**


  1.Find the SmaCQA option:

  ![Choose SmaCQA Option Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/choose_smacqa_model.PNG)

  2.Choose the folder where save the model generated:
  
  ![Choose Folder for SmaCQA model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/choose_folder_smacqamodel.PNG)

  3.Choose the option "Model" for the root of the SmaCQA model
  
  ![File Option](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/root_smacqa.png)

  4.Once the finish button has been pressed, a textual model will have been generated for the definition of value exchanges. It is necessary to specify the actors (In this case Developer and Investo) and the value object (In this case, Pledge) being traded for each value exchange in which we wish to reflect the inherent conditions of this.

  ![SmaCQA Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqa_model.PNG)
  
**Generate a HTML view from SmaCQA model**

To export the information collected in the textual question-and-answer model about an e3value value model to HTML format, click on the button in the IDE toolbar shown in next Figure:

![Export to HTML](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/generatorTable.png)

After this, the environment will generate a file with an HTML extension, which can be viewed by any browser. The file contains a visual representation in the form of a table, as shown in next Figure, with the information collected from the textual question-and-answer model.

![HTML SmaCQA view](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqa_model_html.PNG)


