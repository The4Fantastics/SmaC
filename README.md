![SmaC logo](https://github.com/KybeleResearch/SmaC/blob/main/Images/logo.png)
================
* Technological framework to facilitate the development of smart contracts. SmaC is a textual DSL that supports the coding of smart contracts with Solidity. These contracts can be injected to EMF models and then subject to any model-based processing task. In relation to some of the challenges of coding smart contracts, SmaC presents a series of advantages detailed below:  
   1. SmaC establishes a structural pattern for the coding of a smart contract. The specified smart contract is therefore made more readable and understandable by the developer.  
   2. It requires defining a gas control when executing the loop actions. This avoids infinite loops which may lead to security issues.  
   3. Although Solidity allows multiple inheritance, that is, a contract can inherit from several contracts at the same time, SmaC only allows single inheritance, which avoids what is known as the *Diamond Problem*. We advocate the use of interfaces to obtain external functionality that is defined outside the smart contract.  
   4. It contains a series of ad-hoc facilities that can be easily extended or modified at the user's request. Some of these facilities are code autocompletion, validation and quickfixes.
![SmaC autocomplete display](https://github.com/KybeleResearch/SmaC/blob/main/Videos/SmaCAutocomplete.gif)      
   6. A set of ad-hoc data types (User & Company) has been bundled in the DSL grammar to facilitate the correspondence between SmaC and e3value notation.  
   7. Any SmaC model (.sce extension) is itself a smart contract defined in Solidity. Therefore, it can be compiled to bytecode by any IDE intended for it, such as Remix.  
   8. Apart from the EMF model generated from a smart contract encoded from the designed DSL. SmaC generates through Xtend, an eXtensible Markup Language (XML) model that can be interpreted by the Blockly api from the textual model. In this way, a technological bridge is established between the SmaC and SmaCly tools.  


**SmaC tool use**
_______________
![SmaC tool display](https://github.com/KybeleResearch/SmaC/blob/main/Videos/CalculatorFinishX2.gif)

**ScreenCast**
_______________

![Purchase smart contract encoded with SmaC](https://github.com/KybeleResearch/SmaC/blob/main/Videos/Images/PurchaseSMAC.png)

**Install SmaC from Update Site🔧**
_______________

**It is necessary to have the Xtext, Sirius, e3value and SmaCQA plugins installed previously so that the installation does not generate conflicts.**

* Install Sirius:
   - Link to Sirius install guide:  [Link official site](https://www.eclipse.org/sirius/download.html)
* Install Xtext:
   - Link to Xtext install guide:  [Link official site](https://www.eclipse.org/Xtext/download.html) 

* Install required MDE plugins:

   - Download the e3value Update Site: [Link download](https://github.com/KybeleResearch/SmaC/blob/main/Plugins/e3value_Plugins.zip)
   - Download the SmaCQA Update Site: [Link download](https://github.com/KybeleResearch/SmaC/blob/main/SmaCQA/Plugins/SmaCQA_Plugins.zip)

* If you have an Eclipse running :

  1.Download the SmaC Update Site: [Link download](https://github.com/CristianGM23/SM2/blob/master/SmaC_Plugin_Install.zip)

  2.Choose Help -> Install New Software... from the menu bar and click Add...

![Install New Software](https://github.com/KybeleResearch/SmaC/blob/main/Images/INNoVaSerV_InstallNewSoftware.png)

  3.Choose the SmaC Update Site File and choose a name. Then, you click Add...

  4.Choose the SmaC plugin and click Next.

![Install New Software](https://github.com/KybeleResearch/SmaC/blob/main/Images/INNoVaSerV_Install_SmaC_Plugin.png)

  5.Check the plugins that Eclipse will proceed to install.

  6.Accept the license's terms.

  7.Skip the warning message about download source trust.

  8.After a quick download and a restart of Eclipse

**SmaC Guide📖**
_______________________
* If you have an Eclipse running:

  1.Choose New -> Project -> Choose a name for your project -> Click Finish

  2.Choose New -> Other -> Search by: "SmaC Model" in the search box -> Choose option "SmaC model"

  3.Choose Smac Model's name -> Choose "File" element as the root of the model -> Ok

![Select Root Model](https://github.com/KybeleResearch/SmaC/blob/main/Images/SmaC_ProcessCreationModel.JPG)

  4.Write a Solidity Smart contract.
  
Download a SmaC Guide PDF: [Link download](https://github.com/SM2/blob/master/SmaCUpdateSite.zip)

**Tips📖**
________________________
* Language Patterns:

  1.Define compiler's version **(Obligatory).**

  2.Define import(s).

  3.Define libraries.
  
  4.Define interface(s).
  
  5.Define asbtract contract(s).

  6.Define contracts **(At least 1).**

  7.Define local variable(s) (structs, address, uint, byte, string, enums, etc.).

  8.Define contract's constructor(s).

  9.Define contract's modifier(s).

  10.Define contract's event(s).

  11.Define contract's function(s).

* When defining a contract using the tool, it proposes code autocomplete suggestions using the CTRL + SPACE key combination

* Language demands a gas restriction within the loops.

