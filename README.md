# Big Data
Welcome to the Big Data repository, a testament to my proficiency in Big Data technologies. This project serves as a comprehensive showcase of my skills in leveraging [BigQuery](https://cloud.google.com/bigquery?hl=en), SQL, Python, and [Tableau](https://www.tableau.com/) to handle large datasets effectively.

My expertise lies in the seamless management of databases, encompassing tasks such as data cleaning, summarization, calculation of summary statistics, and the creation of visually appealing and insightful live dashboards. Through the integration of cloud services and powerful Business Intelligence tools like Tableau, I have demonstrated my ability to analyze data and extract meaningful insights crucial to stakeholders.

Join me on this journey through the intricacies of Big Data, where every line of code and visualization is a reflection of my dedication to excellence in data management and analysis.

## Overview
1. [Analyzing BigQuery Data with SQL](https://github.com/gmusebe/BigData_Landscape/tree/main/BigQuery)
2. [Executing SQL Queries in Python](https://github.com/gmusebe/BigData_Landscape/tree/main/Python)
3. [Visualising Data in Python](https://github.com/gmusebe/BigData_Landscape/tree/main/Python#visualising-data-in-python)
4. [Syncing Tableau with BigQuery and Creating Visual Dashboards](https://github.com/gmusebe/BigData_Landscape/tree/main/Tableau)

### Prequisites
This project assumes one has:
1. Installed [Visual Studio Code](https://code.visualstudio.com/)
2. Setup [Google Cloud Platform](https://cloud.google.com/)
3. Prior knowlege of [Python](https://www.python.org/)
4. Prior knowledge of [SQL](https://aws.amazon.com/what-is/sql/#:~:text=Structured%20query%20language%20(SQL)%20is,relationships%20between%20the%20data%20values.)
4. Installed [Tableau](https://www.tableau.com/)
5. Experience with CLI

## Environment Setup
We will be using VSCode to access BigQuery and execute SQL queries remotely. 

### [BigQuery Runner](https://marketplace.visualstudio.com/items?itemName=minodisk.bigquery-runner)
Install the "BigQuery Runner" VSCODE for the extension section.

![bigquery runner](./images/bigquery.png "bigquery runner installer")

### Authenticate: Gcloud Credential:

#### [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install)
  1. Download the [google-cloud-cli-460.0.0-darwin-arm.tar.gz](https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-460.0.0-darwin-arm.tar.gz)
  2. Move the zip file to the home folder in MAC:

      `mv /Users/ivanmusebe/Downloads/google-cloud-cli-460.0.0-darwin-arm.tar.gz /Users/ivanmusebe`
      
      - The command moves the Google CLI from the downloads directory to Home your Home directory. Now extract the `.tar.gz`. You will have a new directory named `google-cloud-sdk`.
  3. Use the install script to add gcloud CLI tools to your `PATH`:

      - Run: `./google-cloud-sdk/install.sh`

      Prompts from the command:
      
      - `Do you want to help improve the Google Cloud CLI (y/N)?` Response `y`Press Enter.
      -  `Modify profile to update your $PATH and enable shell command completion? Do you want to continue (Y/n)?` Response `y` Press Enter.
      - `Enter a path to an rc file to update, or leave blank to use [/Users/ivanmusebe/.zshrc]:` Leave blank & Press Enter.
      - `Download and run Python 3.11 installer? (Y/n)?` Response `n` Press Enter.

      If you don't have Python installed, enter `y` and this will proceed to install Python in your MAC. To confirm you have Python installed run the command `python3 -V`.

Google Cloud CLI is now installed 

4. Run `gcloud auth application-default login` in your terminal.

    This will open google authentication on your browser:
    - Select your preffered gmail account and allow access.
    - Once the CLI has permission from the browswer, one can select/create a GCP project to work with.
    -  A successful authentication will end you up [here](https://cloud.google.com/sdk/auth_success).

5. Set `bigqueryRunner.projectId` in `setting.json`.
    - Press `CTR + Shift + P`  select `Preferences: Open Default Settings (JSON)`
    - Under **BigQuery Runner > Default Dataset: Project ID** click `Edit in settings.json` and paste `"bigqueryRunner.projectId": "{project_name}"`

    `Project_name` is the project in GCP that you selected in step 4. 

For each step in the following repository ends you with a Tableau dashboard for monitoring earthqauke frequencies:.

## Tableau Dashboard
The live dashboard can be found [here](https://public.tableau.com/views/EarthQuakeAnalysis_17062746643850/EarthquakeDistributionBoard?:language=en-US&:display_count=n&:origin=viz_share_link):

<div class='tableauPlaceholder' id='viz1706354511459' style='position: relative'><noscript><a href='#'><img alt='Earthquake Distribution Board ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ea&#47;EarthQuakeAnalysis_17062746643850&#47;EarthquakeDistributionBoard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='EarthQuakeAnalysis_17062746643850&#47;EarthquakeDistributionBoard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ea&#47;EarthQuakeAnalysis_17062746643850&#47;EarthquakeDistributionBoard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>



