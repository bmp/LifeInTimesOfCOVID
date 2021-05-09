VAR sanity=100
VAR ego=100
VAR health=100
VAR org_name=""
VAR emp_count=0
VAR fundsfororg=50
VAR fcrastatus=0
VAR COVIDWorkstatus=0
VAR counter=0

May, 2021

India has become the first country to record over 400,000 new cases in a single day, with continued loss if lives. The nation’s healthcare system is overwhelmed and has buckled. Stranded migrants are leaving cities en masse, and marginalized communities across India are enduring the effects of under planning and unpreparedness on part of the government. The double marginalization resulting from poverty and lack of access has intensified the suffering of those farthest behind, and pushing even the middle-income groups into poverty.  
+ Would you like to address this problem?
* Yes
-> OrgDetails
* No
-> ending

=== OrgDetails ===
 You lead an organisation in the development space in India and now need to take decisions to help those around you. Your work involves working with multiple stakeholders to make transformational change.-> OrgName 

= OrgName
What is your organisation's name?

* Saviour
    ~org_name="Saviour"
    -> OrgSize
* Enabler
    ~org_name="Enabler"
    -> OrgSize
* Solver
    ~org_name="Solver"
    -> OrgSize
* Accelerator
    ~org_name="Accelerator"
    -> OrgSize
* Catalyst
    ~org_name="Catalyst"
    -> OrgSize

= OrgSize
~fcrastatus=RANDOM(0,1)
You have poured your heart and soul into {org_name}. {org_name}'s work has been cited across the world and has received many awards. There have been numerous reports in the media about your work. How many people do you have in your organisation?

* 10
    ~emp_count = 10
    -> DecisionTime
* 25
    ~emp_count = 25
    -> DecisionTime
* 50
    ~emp_count = 50
    -> DecisionTime
* 100
    ~emp_count = 100
    -> DecisionTime

= DecisionTime
{
 - fundsfororg <= 0: -> nofundsshutdown
}

Given the upheaval in the country, a few of your funders have decided to divert funding to help with the COVID situation in the country. What would you like to do?

* [Shutdown] -> shutdownbychoice

* [Change your organisation's focus to COVID] -> pivot

* [Continue working as usual and add new COVID-focused projects] -> manage

=== pivot ===
~COVIDWorkstatus=1

You have made a brave and tricky choice for the organisation.
    {
    - fundsfororg > 0:
        ~ego=ego*2
        You have existing projects and you need to change your focus to COVID relief and response. You let your existing funders know and decide to open new funding avenues. 
    - fundsfororg <=0:
        ~ego=ego*0.50
        Or have you? You were forced into a corner as you ran out of funding, and you are forced to take a hard, long look at yourself in the mirror. 
        {
        - ego > 60: You calm yourself down by thinking of the battles you've won, the change you've achieved and decide to soldier on.
        - else: -> moraleshutdown
        }
    }


* [Next] -> scenarios

=== manage ===
~COVIDWorkstatus=2
~ego=ego*1.1
~health=health*0.8
~sanity=sanity*0.9

You are trying to ensure that you can manage your existing projects and help out with COVID related work as much as possible. While this seems to be the right choice, it is affecting your health and the organisation's focus and health.

All the best!

* [Next] -> scenarios

=== nofundsshutdown ===

You do not have funding to continue the organisation! You have to find jobs for all your colleagues and wish them well for the future. Unfortunately, you are forced to shut your organisation down. 
~ego=ego*0.25
    {
    - health>80: You are healthy and ready for new battles!
    - health<=80 && health>60: You make peace with yourself that you are relatively healthy in these times.
    -else: You are tired and in need of a long rest and recuperation.
    }
    { 
    -sanity>75: You do not have to worry about your mental health! 
    - else: You feel you have gone mad and world is burning around you!
    }
    {
    - ego > 80: And proud of your choices.
    - ego <80 && ego > 60: Happy with the choices you've made.
    - ego <=60 && ego > 30: Unsure of yourself.
    - else: Dejected and tired.
    }

* [End] -> ending

=== healthshutdown ===

You continue to work yourself to the bone, this is unsustainable and the you have to give up your position in the organization. You are exhausted and need to seek medical help.
~ego=ego*0.25
    { 
    -sanity>75:But are still sane! 
    - else: And are almost mad!
    }
    {
    - ego > 80: But proud of your choices.
    - ego <80 && ego > 60: Happy with the choices you've made.
    - ego <=60 && ego > 30: Unsure of yourself.
    - else: Dejected and with no hope.
    }

* [End] -> ending

=== moraleshutdown ===

You lose hope, your feel your work has no impact or change on the world around you, and you've retired.
    {
    - health>80: But you are healthy!
    - health<=80 && health>60: Only relatively healthy.
    - else: Tired and in need of a long rest and recuperation.
    }
* [End] -> ending

=== shutdownbychoice ===
You have decided that {org_name} will shut down.
    {
    - health>80: You are healthy and ready for new battles!
    - health<=80 && health>60: You are relatively healthy.
    - else: You are tired and in need of a long rest and recuperation.
    }
    { 
    - sanity>75: With your sanity intact! 
    - else: Almost mad!
    }
    {
    - ego > 80: And proud of your choices.
    - ego <80 && ego > 60: Happy with the choices you've made.
    - ego <=60 && ego > 30: Unsure of yourself.
    - else: Dejected and tired.
    }
* [End] -> ending

=== scenarios ===
~counter=counter+1
{
 - counter > 10: -> ending
}
{
 - fundsfororg <= 0: -> nofundsshutdown
}
{
 - health <= 10: -> healthshutdown
}
{
 - ego <= 10: -> moraleshutdown
 - sanity <= 10: ->moraleshutdown
}
~ temp scenario_picker = RANDOM(1, 8) 

{scenario_picker:
    - 1: -> nocostextension
    - 2: -> teammemberfallssick
    - 3: -> unpaidCOVIDwork
    - 4: -> paidCOVIDwork
    - 5: -> crowdfundedCOVIDrelief
    - 6: -> newgrantopportunity
    - 7: -> teammemberfallssick
    - 8: -> covidstoppage
}

=== nocostextension ===
~health= health*0.9
~sanity= sanity*0.9
{
 - health <= 5: -> healthshutdown
}
{COVIDWorkstatus:
- 0: You have decided to continue with your existing projects. However, you realise your funding options are becoming smaller and your peers are raising large amounts of funding for their COVID related work. ->scenarios
- 1: Your existing funders are not happy with your choice, but they understand the reasons that have forced your hand.->scenarios
- 2: Since you have decided to continue with your existing projects and work on COVID related projects, your current work has suffered. You need to request your funders for a no-cost extension, and your funder {~approves your request.->extentsionapproved|denies your request.->extensiondenied}
}

=== unpaidCOVIDwork === 
Your {&partner organisation|previous funder|project funder|former colleague|family member|government partner|partner organisation}  reaches out to you, they need your support. There is an urgent need to address a COVID related emergency. Do you wish to take up this short unpaid assignment?
* Yes
    ~health= health*0.9
    ~sanity= sanity*0.9
    ~ego=ego*1.1
    {
     - health <= 5: -> healthshutdown
    }
    ~fundsfororg=fundsfororg-10
    {
    - fundsfororg <= 0: -> nofundsshutdown
    }
    {
    - sanity <= 10: -> moraleshutdown
    }
    Congratulations on taking up the offer and fighting the pandemic! -> scenarios
* No
    ~ego=ego*0.9
    {
    - ego <= 10: -> moraleshutdown
    }
    Though it was tricky, this might turn out to be a wise choice. -> scenarios

=== paidCOVIDwork === 
{COVIDWorkstatus:
- 1:
    ~ego=ego*0.9
    ~health=health*0.9
    You stumble upon an avenue wherein you are offered a short term contract to provide COVID relief. Since you had decided to work on projects related to COVID, you are contacted by {&a foreign funder.->foreignfunder|an Indian funder.->indianfunder}
 -0:
    ~fundsfororg=fundsfororg-10
    Since you decided not to work on COVID related projects, you are ineligible for these grants.
- 2:
    ~ego=ego*1.1
    ~health=health*0.8
    ~sanity=sanity*0.9
  As you had decided to do both COVID relief and existing work, you have sent out a number of requests to people you know. Luckily, you are contacted by {&a foreign funder.->foreignfunder|an Indian funder.->indianfunder}
}
* [And we soldier on! One firefight to another:] -> scenarios
* [No, I am tired] -> shutdownbychoice

=== crowdfundedCOVIDrelief === 
Your {&partner organisation|previous funder|former colleague|family member|government partner}  reach out to you, they need your support. However, they do not have funding and wish to begin a crowdfunding campaign for this work. You agree and work with them to launch the campaign and begin work. 
~ temp chance = RANDOM(1, 3)
{chance:
- 1: 
    ~fundsfororg=fundsfororg+10
    ~sanity=sanity*1.1
    ~ego=ego*1.1
    Congratulations! The campaign was a success and you receive the funding required.
    * [And we soldier on! One firefight to another:] -> scenarios
    * [No, I am tired] -> shutdownbychoice
- 2: 
    ~fundsfororg=fundsfororg-5
    ~sanity=sanity*0.9
    ~ego=ego*0.9
    Unfortunately, the campaign was only partially successful. You had to spend the organisations resources to complete the project.
    * [And we soldier on! One firefight to another:] -> scenarios
    * [No, I am tired] -> shutdownbychoice
- 3: 
    ~fundsfororg=fundsfororg-10
    ~sanity=sanity*0.8
    ~ego=ego*0.8
    This campaign was a total failure and you have not been able to help your partner and your existing projects have suffered. 
    * [And we soldier on! One firefight to another:] -> scenarios
    * [No, I am tired] -> shutdownbychoice
}

=== newgrantopportunity === 
{
- sanity <=60:
    ~fundsfororg = fundsfororg*0.9
    ~ego = ego*0.9
    You and the organisation are close to burning out and not being able to produce good quality work.
    * [And we soldier on! One firefight to another:] -> scenarios
    * [No, I am tired] -> shutdownbychoice
- else:
    ~fundsfororg = fundsfororg+10
    ~sanity = sanity*1.1
    ~ego = ego*1.1
    Due to the availability of a new project grant, your team and you are excited about this opportunity during these harsh and strange times. You apply to the grant and are excited to know that your proposal has been approved. 
    * [And we soldier on! One firefight to another:] -> scenarios
    * [No, I am tired] -> shutdownbychoice
}



=== teammemberfallssick === 
~fundsfororg=fundsfororg-10
~sanity=sanity*0.8
~ego=ego*0.8
~health=health*0.7
COVID {&has affected you personally, you have tested positive and you are out of action for 3 weeks.|has affected your organisation, your colleague has tested positive and is in isolation for 2 weeks. They cannot work for the next one month due to complications.|has affected you personally, and cannot work for the next month.|has struck your organistion, multiple people are infected in your team, you need to shut your offices, sanitize them and take care of your team members.} {org_name} pays a heavy price for this as there is limited bandwidth available from the team.

* [Let me try and push this forward] -> scenarios
* [No, I am tired of people falling sick around me!] -> shutdownbychoice

=== covidstoppage === 
~fundsfororg=fundsfororg-10
~sanity=sanity*0.8
~ego=ego*0.8
Due to the raging pandemic, {&your fieldwork is suspended and you will have to wait for two months to begin work.|your project deliverables have to be changed and you need to negotiate with your funder.|your project is suspended by the funder as they would like to prioritize COVID work.|your partner organisation is in stress and cannot contribute to the project.|your fieldwork is suspended and you will have to wait for two months to begin work.}

* [And we soldier on! One firefight to another:] -> scenarios
* [No, I am tired of what is happening around me. I would like to retire.] -> shutdownbychoice

=== extensiondenied === 
~ego=ego*0.9
~fundsfororg=fundsfororg-10
~sanity= sanity*0.8
You and your team are working overtime to ensure the deliverables can be met and do justice to the COVID work. 

* [No, I am tired] -> shutdownbychoice
* [And we soldier on! One firefight to another:] -> scenarios

=== extentsionapproved === 
~ego=ego*1.1
~fundsfororg=fundsfororg-10
~sanity= sanity*1.1
Since your funder understands the challenges that have resulted due to COVID all around, they extend your deadlines based on your request and ask you and your team to take care and be prepared for a long battle.
* [And we soldier on! One firefight to another:] -> scenarios
* [No, I am tired] -> shutdownbychoice

=== foreignfunder === 
{fcrastatus:
- 1: 
    ~fundsfororg=fundsfororg+10
    ~sanity=sanity*1.1
    ~ego=ego*1.1
    Since you have the clearance from the Government of India, you can continue to carry out the COVID related work with this grant from outside India.
    * [And we soldier on! One firefight to another:] -> scenarios
    * [No, I am tired] -> shutdownbychoice
- 0: 
    ~sanity=sanity*0.9
    ~ego=ego*0.9
    Since you do not have clearance to receive funding from outside India by the Government, you cannot carry out this work.
    * [And we soldier on! One firefight to another:] -> scenarios
    * [I think I need to shutdown] -> shutdownbychoice
}


=== indianfunder === 
~fundsfororg=fundsfororg+10
~sanity=sanity+10
Congratulations! You have received funding to continue the COVID related work from a {&philanthropic body.|an individual funder.} 
* [And we soldier on! One firefight to another:] -> scenarios
* [No, I am tired] -> shutdownbychoice

=== ending ===
# CLEAR

# IMAGE: images/ending.jpg

Sleep well, Oh voyager, 
Ere the sun sets!
As the storm clears,
and the world sleeps,
look to the skies,
the North Star shines,
Keep ye faith,
and hope,
For the journey never ends!

* [Debug] -> debug

=== debug ===
# CLEAR
End state values: 
Health= {health} 
Mental health= {sanity} 
Pride= {ego} 
Organisation funds= {fundsfororg} 
Scenarios run= {counter} 

-> END