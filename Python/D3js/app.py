# pip install Flask pandas google-cloud-bigquery

from flask import Flask, render_template
from google.cloud import bigquery
import pandas as pd

client = bigquery.Client(project='youtube-factcheck')

app = Flask(__name__)

@app.route('/')
def index():
    # Sample earthquake data (replace this with your actual data)
    df_earthquake = client.query(
        '''
        SELECT
        year, COUNT(*) AS count
        FROM
        `youtube-factcheck.earthquake_analysis.earthquakes_copy`
        GROUP BY year
        ORDER BY year;
        ''').result()
    
    df_earthquake = pd.DataFrame(df_earthquake)
    
    return render_template('index.html', df_earthquake=df_earthquake.to_json(orient='records'))

if __name__ == '__main__':
    app.run(debug=True)