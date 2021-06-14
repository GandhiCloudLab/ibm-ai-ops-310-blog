# Create and Execute RunBook in Watson AIOps

This article explains about how to create and execute Run Book in Watson AIOps.

The article is based on the the following

- RedHat OpenShift 4.6 on IBM Cloud (ROKS)
- Watson AI-Ops 3.1.0


## 1. Create RunBook

The creating runbook involves the following steps.

- Connect Backend System with SSH
- Create New Automation
- Create RunBook
- Create Trigger

### 1.1. Connect Backend System with SSH

In the event manager click on `Automation --> Runbook`

<img src="images/image-11.png">

We are going to create a Runbook which has some automation scripts.

Click on `Automation --> New Automation`

<img src="images/image-12.png">

Being, it is first time, we need to configure Integrations to connect from Event Manager to the target system, from where the script is going to get executed.

Click on `Configure`

<img src="images/image-13.png">

You are in Integrations page.

Click on `Configure`

<img src="images/image-14.png">

ssh into the target system.

<img src="images/image-15.png">

Copy the file name high lighted.

<img src="images/image-16.png">

In the target system, vi into the file.

<img src="images/image-17.png">

Copy the Key from the UI.

<img src="images/image-18.png">

Paste the key in the vi and save it.

<img src="images/image-19.png">

Click on `Save`.

<img src="images/image-20.png">

You can see the script is connected with the target system.
<img src="images/image-21.png">

### 1.2. Create New Automation

Goto `Automation > Runbooks`
<img src="images/image-22.png">

Click on `Automations > New Automation`
<img src="images/image-23.png">

Enter values for the High lighted fields.

<img src="images/image-24.png">

<img src="images/image-25.png">

Give your script in the `Script` text box.

This script will get executed when the runbook is started.

Click on `Edit` button in the `target` row.
<img src="images/image-26.png">

You can enter here the `IP Address` of the target system.

Click on  `Save`

<img src="images/image-27.png">

Click on `Edit` button in the `user` row.

<img src="images/image-28.png">

You can enter the `user id` here to login into target system.

<img src="images/image-29.png">

Click on  `Save`

<img src="images/image-30.png">

You can see the automation created here.

<img src="images/image-31.png">

### 1.3. Create RunBook

Click on `Library` and `New Runbook`.

<img src="images/image-32.png">


<img src="images/image-33.png">

Enter `Name` and `Description`.

Click on `Add automated step`.

<img src="images/image-34.png">

Select the listed `Automation`, which we created already.

Click on `Select this automation`.

<img src="images/image-35.png">

<img src="images/image-36.png">
<img src="images/image-37.png">

It shows parameter mappings. you can choose `Use Default Value`

Click on `Save`.

<img src="images/image-38.png">

Click on `Publish`.

<img src="images/image-39.png">

Shows created Runbook.

<img src="images/image-40.png">

### 1.4. Create Trigger

Click on `Triggers > Create New Trigger`.

<img src="images/image-41.png">

Give `Name` and `Description`.

Give `Attribute`, `Operator` and `Value`.

Here `Attribute` and `Value` should match the event you get in event manager. Then only this runbook will get associated with that event.

<img src="images/image-42.png">

#### Sample Event. 

Here Attribute is `Summary` and the value of that is `Rating Pod down`
```
  .....
            "Node":"ratings-v1-b6994bb9-js9rj",
            "AlertGroup":"Availability",
            "AlertKey":"ServiceDown",
            "Summary":"Rating Pod down",
            "Identifier":"ratings-v1-b6994bb9-js9rj",
            "OwnerGID":0,
            "Severity":5,
            "OwnerUID":0,
            "Type":1,
            "Manager":"CEM",
            "ScopeID":"BookInfoD",
            "Customer":"BookInfoDEnterprise"
  .....
```

Choose the runbook.

Click on `Select the Runbook`.

<img src="images/image-43.png">

Uncheck  `Manual` in `Execution`.

Click on `Save`.

<img src="images/image-44.png">

Runbook is created.

<img src="images/image-45.png">


## 2. Execute RunBook

Whenever an event created in event manager, the event manager flags the event if the event attribute matches to the trigger condition of any of the runbook stored in event manager.

You can see the dot under `Runbook` column for the `Rating Pod Down` event.

Click on the event record

<img src="images/image-61.png">

On the right side, you will have list of actions.

Click on `Launch Runbook`

<img src="images/image-62.png">

It opens up the Runbook page.

Click on `Start Runbook`

<img src="images/image-63.png">

It contains 1 step only.

Click on `Run`

<img src="images/image-64.png">

Step executed and status is successful.

Click on `Complete`

<img src="images/image-65.png">

Give feedback about the runbook.

Click on `Runbook Worked`

<img src="images/image-66.png">

Click on `Execution`

<img src="images/image-67.png">

You can see the execution history.

<img src="images/image-68.png">