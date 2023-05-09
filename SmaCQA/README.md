**SmaCQA Tool**
================
SmaCQA is a textual DSL developed using the Xtext tool incorporated into the Sirius framework. SmaCQA arises due to the limitation of the e3value notation to represent the circumstances in which value exchanges take place between the actors that are part of the model presented in this notation. This limitation makes it difficult to establish a useful technological bridge using MDE to extract, from an e3value model, its corresponding smart contract model. Therefore, the purpose of SmaCQA is to act as support during the model transformation process, supporting the information specified by the user regarding the temporal and economic context for each value exchange between actors.

**SmaCQA Tool Display**
_______________

![SmaCQA tool display](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/20230508_134207.gif)

**ScreenCast**
_______________

![SmaCQA tool](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/energycase_smacqa_iteration3.PNG)


**SmaCQA Metamodel View**
_______________________

![SmaCQA tool](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/smacqametamodel.png)
_______________


**SmaCQA Questions**
_______________________
1. DataQuestion
    - If the exchange of value is subject to a duration of time. What would this be? (indicated in minutes,days,weeks or years)
    - If the exchange of value could only take place after a certain time. What would this be? (indicated in minutes,days,weeks or years)
    - Can the value exchange be repeated over time?
    - Are the same conditions always maintained when exchanging value?
    - ValueObjectQuestion (The questions collected below are mutually exclusive based on the nature of the object of value negotiated
    in the exchange of value).
        * If the object of value being traded is a token, the user can specify the information in the following sets of responses according to the nature of the token. If the user wishes tospecify that the object of value is a non-fungible token (NFT), they must answer the set of specific questions for ERC-721 tokens shown in Tab. B.1.
    If it is a fungible token (ERC-20 and ERC-223), users must specify the information in the set of requested questions shown in Tab. B.2. 
    ![Token Questions](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/questionstokens.PNG)
        * If the object of value negotiated in the value exchange is a tangible entity that can be represented as a digital entity (not a token).
    What are the properties of that object? If the object of value being negotiated is a ''physical'' entity that possesses a series of properties and can be               represented digitally, the user can specify these by declaring the name of the property and the type of value associated with it (whether it is a text, a number,       or a property that reflects two opposing states)
        * Is the object of value a right that can be reflected as active or in-active?. If the object of value is a negotiable right or service that can
be considered as representing a situation represented by two opposite states

2. LegalQuestion
    - What would be the minimum legal age if necessary in this exchange?
    - What is the name of the tax? 
        - Who collects the tax?
3. EconomyQuestion
    - Which would be the minimum amount if necessary in this exchange
_______________________
**Import SmaCQA plugins (SmaCQA Installation)**

If you want to use SmaCQA in your own Eclipse distribution, you can import SmaCQA plugins to use it.
1. First, download SmaCQA Plugins and unzip the file in your desktop.
2. Open your Eclipse IDE and choose the "Install New Software" option that appears in the "Help" section of the Eclipse IDE toolbar. 
  ![Install New Software](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/install%20New%20Software.png)
3. Once this option is selected, a wizard will open to import the plugins. You must press the "Add" button.
  ![Import plugins](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/install_add.png)
4. Choose the SmaCQA folder and define a name for the import. Confirm the changes.
  ![Complete SmaCQA Plugins](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/data_addplugin.PNG)
5. Choose the SmaCQA Plugin import and press the button "Next" until complete the installation.
  ![Confirm Import](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqa_install.png)
_______________________
**Create SmaCQA model**

  1.Find the SmaCQA option:

  ![Choose SmaCQA Option Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/choose_smacqa_model.PNG)

  2.Choose the folder where save the model generated:
  
  ![Choose Folder for SmaCQA model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/choose_folder_smacqamodel.PNG)

  3.Choose the option "Model" for the root of the SmaCQA model 
  
  ![File Option](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/root_smacqa.png)

  4.Once the finish button has been pressed, a textual model will have been generated for the definition of value exchanges. It is necessary to specify the actors (In this case, Developer and Investor) and the value object (In this case, Pledge) being traded for each value exchange in which we wish to reflect the inherent conditions of this.

  ![SmaCQA Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqa_model.PNG)
  _______________________
**Generate a HTML view from SmaCQA model**

To export the information collected in the textual question-and-answer model about an e3value value model to HTML format, click on the button in the IDE toolbar shown in next Figure:

![Export to HTML](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/generatorTable.png)

After this, the environment will generate a file with an HTML extension, which can be viewed by any browser. The file contains a visual representation in the form of a table, as shown in next Figure, with the information collected from the textual question-and-answer model.

![HTML SmaCQA view](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqa_model_html.PNG)


