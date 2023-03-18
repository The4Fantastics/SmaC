**SmaCQA Tool**
================
Technological framework to facilitate the development of smart contracts. SmaCly allows the generation of smart contract models by representing them in the form of graphic blocks. These blocks are generated by Google's Blockly library. In turn, SmaCly allows to import from SmaC models generated by this tool that are readable by SmaCly. This is done by transforming the smart contract model with the .sce extension into a model with the .xml extension readable by SmaCly. The application is in the compressed file named SmaCly.zip, which contains the SmaCly tool as a whole. This tool is made up of a JS folder where the definition of the blocks and the functionality offered by the tool are found. It also consists of an .html file that presents the application so that the user can interact with it.
*SmaCly works offline too, you don't need Internet*

**SmaCly Tool Display**
_______________

![SmaCly tool display](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Videos/SmaCly_Introduction.gif)

**ScreenCast**
_______________

![SmaCQA tool](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqa.PNG)


**SmaCQA Metamodel View**
_______________________

![SmaCQA tool](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Images/smacqametamodel.png)
_______________

**Technological bridge between SmaC and SmaCly**

* Import SmaCly Model (file.xml) generated from SmaC :

  1.Click on the button to import file 

  ![Import XML Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Images/SmaCly_import.jpg)

  2.Select the .xml file that contains the model generated by SmaC from a file with the extension .sce

  3.Click on the Transform XML to Blockly button
  
  ![Transform XML Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Images/SmaCly_import1.JPG)

  4.The application will represent the smart contract model in the form of blocks.

  ![See XML Model](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Images/SmaCly_import2.JPG)
  
* Video demonstration of the technological bridge between SmaC and SmaCly:

 ![Technological bridge](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Videos/transform_file.gif)

**Tips**
________________________
* Language Patterns:

  1.Define file block **(Obligatory).**
  
  2.Define compiler's version block **(Obligatory).**

  2.Define libraries blocks.
  
  3.Define import(s) blocks.
  
  4.Define interface(s) blocks.

  5.Define contracts **(At least 1, Obligatory).**

  6.Define local variable(s).

  7.Define contract's constructor(s).

  8.Define contract's modifier(s).

  9.Define contract's event(s).

  10.Define contract's function(s).

* You have a series of smart contract models represented by blocks that follow standards, such as ERC20, ERC223, etc. To use them, you must select the "Standards" option and select the standard you want:
  ![Standards SmaCly](https://github.com/KybeleResearch/SmaC/blob/main/SmaCly/Images/erc20smacly.PNG) 
