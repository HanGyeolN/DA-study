import pandas as pd
from recommend.models import Movie

data = pd.read_csv("data/data.csv")
data['open_date'] = data['open_date'].astype('str')

for i in range(0, len(data)):
    movie = Movie(title = data.loc[i, 'title'],
        title_en = data.loc[i, 'title_en'],
        audience = data.loc[i, 'audience'],
        open_date = data['open_date'][i][0:4] + "-" + data['open_date'][i][4:6] + "-" + data['open_date'][i][6:8],
        genre = data.loc[i, 'genre'],
        watch_grade = data.loc[i, 'watch_grade'],
        score = data.loc[i, 'score'],
        poster_url = data.loc[i, 'poster_url'],
        description = data.loc[i, 'description']
    )
    movie.save()