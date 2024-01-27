# Syncing Tableau with BigQuery and Creating Visual Dashboards

This is a component of our extensive repository for accessing and analyzing BigQuery data using Tableau. This particular section focuses on syncing Tableau with BigQuery and creating visually appealing dashboards. By utilizing the power of Tableau, we aim to enhance the visualization capabilities of the data stored in BigQuery, providing a seamless experience for data analysis.

## Integration Steps
1. [Create](https://cloud.google.com/bigquery/docs/analyze-data-tableau) a BigQuery dataset.
The following steps will help you access the Earthquake data into the working Google project.
2. In Tableau Desktop, in the Connect pane, select `Google BigQuery` as your data source.
3. Select authentication method as `Sign in using Service Account`. Input the `path` to the downloaded JSON file `service acccount API Key`.

![bigquery-autho](../images/BigQuery-%20Autho.png "bigquery-autho")

4. Click on "Sign In" and authenticate your Google account to establish the connection.
5. Select your `Google Project`  and then the table with the Earthquake data.

Proceed to analysing the data.

## Tableau Dashboard.
The live dashboard can be found [here](https://public.tableau.com/views/EarthQuakeAnalysis_17062746643850/EarthquakeDistributionBoard?:language=en-US&:display_count=n&:origin=viz_share_link):

<div class='tableauPlaceholder' id='viz1706354511459' style='position: relative'><noscript><a href='#'><img alt='Earthquake Distribution Board ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ea&#47;EarthQuakeAnalysis_17062746643850&#47;EarthquakeDistributionBoard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='EarthQuakeAnalysis_17062746643850&#47;EarthquakeDistributionBoard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ea&#47;EarthQuakeAnalysis_17062746643850&#47;EarthquakeDistributionBoard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1706354511459');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='1100px';vizElement.style.height='2627px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='1100px';vizElement.style.height='2627px';} else { vizElement.style.width='100%';vizElement.style.height='2827px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>