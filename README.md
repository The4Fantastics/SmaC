**SmaC Tool**
================
Technological framework to facilitate the development of smart contracts.

**SmaC DSL**
_______________
Definition of a textual language (terminals, rules, patterns) using Xtext for the construction of Solidity smart contract's.

**SmaC tool use**
_______________
![SmaCly tool display](https://github.com/KybeleResearch/SmaC/blob/main/Videos/SmaC_Calculator.gif)

**ScreenCast**
_______________

![Purchase smart contract encoded with SmaC](https://github.com/CristianGM23/SmaC/blob/master/PurchaseTogether.png)

**Install SmaC from Update Site🔧**
_______________

**It is necessary to have the Xtext and Sirius plugins installed previously so that the installation does not generate conflicts.**

* If you have an Eclipse running :

  1.Download the SmaC Update Site: [Link download](https://github.com/CristianGM23/SM2/blob/master/SmaC_Plugin_Install.zip)

  2.Choose Help -> Install New Software... from the menu bar and click Add...

![Install New Software](https://github.com/CristianGM23/SmaC/blob/master/INNoVaSerV_InstallNewSoftware.png)

  3.Choose the SmaC Update Site File and choose a name. Then, you click Add...

  4.Choose the SmaC plugin and click Next.

![Install New Software](https://github.com/CristianGM23/SmaC/blob/master/INNoVaSerV_Install_SmaC_Plugin.png)

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

![Select Root Model](https://github.com/CristianGM23/SmaC/blob/master/SmaC_ProcessCreationModel.JPG)

  4.Write a Solidity Smart contract.
  
Download a SmaC Guide PDF: [Link download](https://github.com/CristianGM23/SM2/blob/master/SmaCUpdateSite.zip)

**Tips📖**
________________________
* Language Patterns:

  1.Define compiler's version **(Obligatory).**

  2.Define libraries.
  
  3.Define import(s).
  
  4.Define interface(s).

  5.Define contracts **(At least 1).**

  6.Define local variable(s).

  7.Define contract's constructor(s).

  8.Define contract's modifier(s).

  9.Define contract's event(s).

  10.Define contract's function(s).

* When defining a contract using the tool, it proposes code autocomplete suggestions using the CTRL + SPACE key combination

* Language demands a gas restriction within the loops.

* Although Solidity allows multiple inheritance, that is, a contract can inherit from several contracts at the same time, SmaC only allows single inheritance, which avoids what is known as the diamond problem. We advocate the use of interfaces to obtain external functionality that is defined outside the smart contract.

