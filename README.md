# Terraform project
## Contents
- [Project Business Requirements](#project-business-requirements)
- [Hypothesis](#hypothesis)
- [Setting UP](#setting-up-the-work-environment)
- [Project Workflow](#project-workflow)
    - [Business Understanding](#business-understanding)
    - [Data Understanding](#data-understanding)
    - [Data Preparatioin](#data-preparation)
    - [Data Modelling](#data-modelling)
    - [Data Evaluation](#data-evaluation)
    - [Deployment](#deployment)
- [Main Libraires](#main-data-analysis-and-machine-learning-libraries)
- [Credits](#credits)
- [Bugs](#bugs)
- [Acknowledgements](#acknowledgements)



## Project Business Requirements
This project is a portfolio project for my cloud engineering bootcamp at Northcoders. In this case strudy, the client has asked me to build an infrastructure where they can have their applications running without any interruption. The client has some following requirements.

- 1 - The client is interested to have an infrastrucure that can host and run application without smoothly
- 2 - The client would like to have the infrastructure as a code (IAC)
- 3 - The client wants to have the infrastructure to cope with increased traffic for future proofing

I decided to build the infrastrure using `Terraform` and deploy it to `aws` with following components
- VPC in `eu-2-west` region
- Three `subnets` in each availability zone
- An `ec2` instance in each subnet
- Create `security group` for all the traffic 
- Deploy application for <em>lights</em>, <em>heating</em>, and <em>status</em> in each instance
- Create a `load balancer (ALB)` to respond to the requests
- Three goups for `ALB`, with eachh containing one instance
- 
## Hypothesis

- Powdery mildew is a white, dusty coating that differentiates them from healthy leaves

### Validation

- I will validate the hypothesis by collecting an image dataset from the client and creating an image montage for both healthy and powdery mildew-affected leaves
- I will test the hypothesis by average image analysis
- I will also test the hypothesis by analysing the difference between average images

## Setting up the work environment

I used the Code Institute student template for Codeanywhere from [template](https://github.com/Code-Institute-Solutions/milestone-project-mildew-detection-in-cherry-leaves). However, I used VS Code instead of Codeanywhere.

### Setting up the local environment

1. I use this template to create my GitHub project repo

2. Opened my VS Code and created a folder where I clone my GitHub repo
   <code>cd folder/to/clone-into/</code>
3. Clone the repo <code>git clone https://github.com/KhanRana/PP5-mildew-detection-in-cherry-leaves</code>

4. Create a new `venv` by <code>python -m venv venv </code> - the name of the virtual env is also `venv`.

5. The python version used throughout is `python 3.9`

6. Open a new terminal and <code>pip install -r requirements.txt</code>

7. In the terminal type <code>pip install jupyter</code>

8. Install `ipykernel`, which provide `IPython` kernel for jupyter server to run in the VS environment

9. Open the jupyter_notebooks directory in the jupyter webpage that has opened and click on the notebook you want to open.

10. Click the button Not Trusted and choose Trust.

Note that the kernel says Python 3. It inherits from the workspace so it will be Python-3.9.1 as installed. To confirm this you can use <code>! python --version</code> in a notebook code cell.

# Project Workflow

The project was carried out using CRISP-DM Process:

- Business understanding
- Data understanding
- Data Preparation
- Data Modelling
- Data Evaluation
- Deployment
  ![CRISP-DM](documents/pages/CRISP-DM_Process_Diagram.png)
  _Source_: [CRISP-DM](https://en.wikipedia.org/wiki/Cross-industry_standard_process_for_data_mining)

## Business understanding

### The rationale to map the business requirements to the Data Visualisations and ML tasks

- Business requirement 1 <br>
  As the client is interested in differentiating a healthy leaf from the mildew contained, it makes it a classification problem. We should have a dataset of two classes: healthy; and powdery mildew". We will then check if the data is balanced: which means both classes have similar label frequency. If the frequency is similar then the data is balanced, and we can proceed to further analysis. The first of which would be to create an `Image Montage` to visually see the difference between the two using the known dataset. An `Image Montage` provides examples from each dataset. We also look at the average image and variability image for both classes to see the patterns on both leaves.

- Business requirement 2 <br>
  If the dataset is balanced then it would not need extensive cleaning and we can proceed to the answer to the second requirement: predicting whether a new leaf is healthy of powdery mildew contained. We will provide the client with a dashboard. For the image prediction, we will use `Convolution Neural Network` to train the ML model. The model can identify patterns, colors, and variations to classify the leaves. We will develop a dashboard that would have both features of showing an image montage and a prediction feature. This will improve the client operations by minimizing human efforts to identify affected plants. The client should be able to use the dashboard for any number of cherry leaves and provide healthy fruit to their clients.

In the following section, we will look at the case for this study and see if it makes an ML business case.

### ML Business Case

In this section, we will look at individual elements of the case and justify how it is an ML business case.

1. What are the business requirements?<br>
   The client would like a tool to identify healthy cherry leaves from powdery mildew contained.
   We understand that ML can be used to identify images and differentiate one from the other if a model has been trained to an acceptable accuracy level.

2. Is there any business requirement that can be answered with conventional data analysis?<br>
   The Requirement 1 can be solved using traditional data analysis methods. However, the second requirement can not be solved using traditional data analysis approaches therefore we would need an ML tool to tackle the challenge.

3. Does the client need a dashboard or an API endpoint?<br>
   The client needs a dashboard.

4. Can you break down the project into Epics and User Stories?<br>
   The project can be broken down into epics and stories. Please see [User Stories](documents/stories/user_stories.md)

5. Ethical or Privacy concerns?<br>
   The client provided the data under an NDA (non-disclosure agreement), therefore the data should only be shared with professionals that are officially involved in the project. Please see [Dataset Content](#dataset-content)

6. What does the client consider a successful project outcome?<br>
   The client can visually see and differentiate healthy leaves from powdery mildew-contained ones.
   An image montage can be created that shows both types of leaves

The client will also be able to predict if a leaf is healthy or contains powdery mildew by uploading images to the dashboard.

7. What are the model's inputs and intended outputs?<br>
   The input is a cherry leaf image and the output is a prediction of whether the cherry leaf is healthy or contains powdery mildew.

8. Does the data suggest a particular model?<br>
   The data suggest it is a binary classification model.

9. What are the criteria for the performance goal of the predictions?<br>
   An accuracy of 97% has been agreed with the client; however, the model has been trained to a 99% accuracy.

10. How will the client benefit?<br>
    The client will not supply the market with a compromised product. Furthermore, the client will also be able to scale up their operations in detecting mildew on other farms by minimising manual work.

### Data Understanding

- The dataset is sourced from [Kaggle](https://www.kaggle.com/codeinstitute/cherry-leaves). We then created a fictitious user story where predictive analytics can be applied in a real project in the workplace.
- The dataset contains +4 thousand images taken from the client's crop fields. The images show healthy cherry leaves and cherry leaves that have powdery mildew, a fungal disease that affects many plant species. The cherry plantation crop is one of the finest products in their portfolio, and the company is concerned about supplying the market with a compromised quality product.

### Data Preparation
Please refer to [Data Preparation](jupyter_notebooks/data_collection.ipynb) and [Data Visualisation](jupyter_notebooks/data_visualisation.ipynb) for details.

### Data Modelling
Please refer to [Data Modelling](jupyter_notebooks/data_modelling.ipynb) for details.

### Data Evaluation
Please refer to [Data Evaluation](jupyter_notebooks/data_modelling.ipynb) for details.

### Deployment
ML Dashboard has been developed and deployed to Heroku.

#### Dashboard Design

**Mildew Detector**
- Page 1: Brief Project Summary
    - General Information
        - Powdery mildew of sweet and sour cherry is caused by Podosphaera clandestina, 
        an obligate biotrophic fungus. Mid- and late-season sweet cherry (Prunus avium) 
        cultivars are commonly affected, rendering them unmarketable due to the covering 
        of white fungal growth on the cherry surface.
        - Initial symptoms, often occurring 7 to 10 days after the onset 
        of the first irrigation, are light roughly circular, powdery-looking patches 
        on young, susceptible leaves (newly unfolded, and light green expanding leaves). 
        Older leaves develop an age-related (ontogenic) resistance to powdery mildew and 
        are naturally more resistant to infection than younger leaves.
        - In contrast to other fungi, powdery mildews do not need free water 
        to germinate but germination and fungal growth are favored by high 
        humidity (Grove & Boal, 1991a)."

    - Project Dataset
        - The available dataset contains 4208 images: 2104 each for healthy and powdery mildew. Project dataset can be downloaded from <a>Project Dataset</a>.

    - The project has 2 business requirements:
        - 1 - The client is interested in conducting a study to visually differentiate a healthy cherry leaf from one with powdery mildew.
        - 2 - The client is interested in predicting if a cherry leaf is healthy or contains powdery mildew.

- Page 2: Leaves Visualise
    - The client is interested in conducting a study to visually differentiate a healthy cherry leaf from one with powdery mildew

    - [x] Difference between average and variability image
    - [x] Difference between average healthy and average powdery mildew leaves
    - [x] Image montage

- Page 3: Mildew Detection
    - The client is interested in predicting if a cherry leaf is healthy or contains powdery mildew.
    - You can download a set of healthy and powdery mildew leaves for live prediction. <a>Kaggle Link</a>

    Upload a cherry leaf image. You may select more than one. <button>Browse files</button>

- Page 4: Project Hypothesis
    - Powdery mildew is a white, dusty coating on leaves that differentiates them from healthy leaves.
    - An Image Montage shows that powdery mildew-affected leaves have patches of white coating, and are discolored.
    The average image also shows that powdery mildew-affected leaves are lighter in color.
    - Variability and Average Difference images show no variation around the middle of either leaf; however, there is clear variation in contrast around the middle of the healthy leaf.

- Page 5: ML Performance Metrics
    Train, Validation, and Test Set: Labels Frequencies
    - ![Label Distribution](outputs/v1/labels_distribution.png)
        - test - powdery_mildew: 422 images
        - test - healthy: 422 images
        - train - powdery_mildew: 1472 images
        - train - healthy: 1472 images
        - validation - powdery_mildew: 210 images
        - validation - healthy: 210 images

    - Model History
        - ![Model Accuracy](outputs/v1/model_training_acc.png)
        - ![Model Loss](outputs/v1/model_training_losses.png)
    <br>
    <br>
    - Generalised Performance on Test Set
        |    |loss|
        |---|---|
        |Loss|0.0467|
        |Accuracy|0.9917|

#### Deployment

**Heroku**

- The App live link is: https://detect-powdery-mildew-7c73e62a3b18.herokuapp.com/
- Set the runtime.txt Python version to a [Heroku-20](https://devcenter.heroku.com/articles/python-support#supported-runtimes) stack currently supported version.
- The project was deployed to Heroku using the following steps.

1. Log in to Heroku and create an App
2. At the Deploy tab, select GitHub as the deployment method.
3. Select your repository name and click Search. Once it is found, click Connect.
4. Select the branch you want to deploy, then click Deploy Branch.
5. The deployment process should happen smoothly if all deployment files are fully functional. 
6. The slug size was too large therefore I added large files which are not required for the app to the .slugignore file.

## Main Data Analysis and Machine Learning Libraries

The following main libraries were used in the project
- **numpy** It is a foundation for pandas and matploblib, both libraries have been built on it. It is used to convert the images into an array for analysis and ML training, calculating means and sd. 
- **pandas** It is used to manipulate the dataset. For example, we used pandas dataframe to save an image prediction report.
- **matplotlib** It is used to plot images such as augmented images and data images.
- **seaborn** It is used to plot image datasets, especially with multiple axes and more features. For example, we used it to plot image montages.
- **tensorflow** ML framework that is used to build, train, and validate the model
- **streamlit** It is used to build the dashboard
- **keras** It is used for image analysis such as augmentation and ML model training.

## Credits

### Content

- The code for data modelling, visualisation and ML model creation, training, and deployment has been taken from Code Institute lessons and walkthrough projects.
- The dashboard and readme.md file has been built using the provided templates
- Instructions on how to implement CNN form validation on the Sign-Up page were taken from [Tensorflow Zero to Hero](https://www.youtube.com/watch?v=KNAWp2S3w94&list=PLZKsYDC2S5rM6yKBs5ParXS6RWda6iAnK).

## Bugs
There are no known bugs in the project. However, as the project is a binary classification model, any image of the required format can be uploaded and the model will classify it as either healthy or powdery mildew.

## Acknowledgements

I would like to acknowledge the following people who have helped me with completing this project:

 - My family for their support and encouragement to take up this challenge
 - The Code Institute support team who have helped me throughout the course
 - I would also like to thank my mentor who has provided guidance and valuable feedback
 - Last but not least a special thanks to the course tutor and content developers, who have put an immense amount of work and consideration into the creation and delivery of the course.


![A hero starting their journey looking at a tower](./media/images/journey.png "A hero starting their journey looking at a tower")

It is time to take those Terraform skills you have been developing and create your own project.

Time to start your journey and create a brand new Terraform project from scratch.

Side note: The image is what AI generated when the words "success, journey and terraform logo" were put into the tool 🤷

You can find the trello board to copy for your project below

[Cloud Ops Terraform Project Template](https://trello.com/b/ANaPDxTY/ce-terraform-project-template)

## Requirements

The target for this project is to create a hosted network of microservices that mocks a smart home network with; a central status service, a lighting service, and a heating service.

But that isn't everything....

Your solution should;

- Be completed using terraform
- Be a production ready network setup with both public and private subnets
- Make use of terraform variables and looping where possible
- Make your code as DRY and reusable as possible by creating modules where you can
- Have DynamoDB tables to account for the services that need them
- Be created with 'design for failure' in mind - we do not want a loss of service if one of the EC2 instances fails
- Be considerate and intentional of how your files and directory structures are named

[Here](https://trello.com/b/ANaPDxTY/ce-terraform-project-template) you will find a trello board with the tickets needed to finish this project.

## Tearing things down

You should run `terraform destroy` to remove everything at the end of each day, if you've created your code well it should be able to recreate each time without issue.

## Submission process

1. Fork this GitHub repository

2. Make a branch for each tickets code `git checkout -b NEW_BRANCH_NAME`

3. Create a Pull Request and merge the branch back into main on GitHub when the ticket is done

4. Submit the Pull Request link to `nchelp pr`

5. Checkout back to the main branch `git checkout main` and pull your code to the main branch `git pull origin main`

6. Create a new branch for the next ticket and repeat until finished.

## Further reading

[Terraform directory structure tips](https://xebia.com/blog/four-tips-to-better-structure-terraform-projects/)

[Terraform best practices structure](https://www.terraform-best-practices.com/examples/terraform)
