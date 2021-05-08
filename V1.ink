VAR sanity=100
VAR ego=100
VAR health=100
VAR org_name=""
VAR emp_count=0
VAR fundsfororg=0

India, 2021
A COVID-19 ravaged country is reeling under the effects of a grossly mismanaged public health system.
+ Would you like to begin?
* Yes
-> OrgDetails
* No
->ending

=== OrgDetails ===
 You lead an organisation in the development space in India and now need to take decisions to help those around you. Your work involves working with multiple stakeholders to make transformational change.->OrgName 

= OrgName
What is your organisation's name?

* Saviour
  ~org_name="Saviour"
  ->OrgSize
* Enabler
 ~org_name="Enabler"
   ->OrgSize
* Solver
 ~org_name="Solver"
   ->OrgSize
* Accelerator
 ~org_name="Accelerator"
   ->OrgSize
* Catalyst
 ~org_name="Catalyst"
   ->OrgSize

= OrgSize
{org_name}'s work has been cited across the world and has received awards across the globe. There have been numerous reports in the media about your work. How many people do you have in your organisation?

* 10
    ~emp_count = 10
    ->DecisionTime
* 25
    ~emp_count = 25
    ->DecisionTime
* 50
    ~emp_count = 50
    ->DecisionTime
* 100
    ~emp_count = 100
    ->DecisionTime

= DecisionTime
Given the upheaval in the country, a few of your funders have decided to divert funding to help with the COVID sitatuation in the country. What do you want to do?

* [Shutdown] -> shutdownbychoice

* [Change your organisations focus] -> pivot

* [Try and manage both] -> manage

=== pivot ===

You have made a brave and tricky choice for the organisation.
    {
    - fundsfororg > 0:
        ~ego=ego*2
        You have existing projects and you need to change your focus to COVID relief and response. You let your existing funders know and decide to open new funding avenues. 
    - fundsfororg <=0:
        ~ego=ego*0.50
        Or have you? You were forced into a corner as you ran out of funding, and you are forced to take a hard, long look at yourself in the mirror. 
        {
        - ego > 60:
            You calm yourself down by thinking of the battles you've won, the change you've achieved and decide to soldier on.
        - else:
            You don't like what you see. A bit of self-doubt creeps in, maybe you have not planned well? Are you letting your teammates down? Maybe everyone around you was right, and you shoould not have gone down this road? 
        }
    }

-> ending

=== manage ===

And try and manage the world now!
-> ending

=== shutdownbychoice ===
The world has gone to hell, but who cares? :-)

Congratulations, {org_name} has shutdown, you've retired 
    {
    - health>80: Healthy and ready for new battles!
    - health<=80 && health>60: Relatively healthy.
    -else: Tired and in need of a long rest and recuperation.
    }
    { 
    -sanity>75:With your sanity intact! 
    - else: Almost mad!
    }
    {
    - ego > 80:
        And proud of your choices.
    - ego <80 && ego > 60:
        Happy with the choices you've made.
    - ego <=60 && ego > 30:
        Unsure of yourself.
    - else:
        Dejected and tired.
    }

-> ending

=== ending ===

Sleep well, Oh voyager, 
Ere the sun sets!
As the storm clears,
and the world sleeps,
look to the skies,
the North Star shines,
Keep ye faith,
and hope,
For the journey never ends!

-> END
