import pandas as pd
import sys
import os

value = sys.argv[2]
choice = int(sys.argv[1])


def county_code(cc):
    # df_1 = df.loc[df['county_name'] == cc]
    # df_1 = df_1[['year', 'observation_percent']]
    # output = df_1.to_json()
    stream1 = os.popen(
        'conda run -n base python detect.py --weights best.pt --img 640 --conf 0.25 --source testimg')
    output = stream1.read()
    print(output)
    sys.stdout.flush()


def city_code(cn):
    df_1 = df.loc[df['city_name'] == cn]
    print(df_1)
    df_1 = df_1[['year', 'observation_percent']]
    output = df_1.to_json()
    print(output)
    sys.stdout.flush()


def state_code(sc):
    df_1 = df.loc[df['state_name'] == sc]
    print(df_1)
    df_1 = df_1[['year', 'observation_percent']]
    output = df_1.to_json()
    print(output)
    sys.stdout.flush()


if __name__ == "__main__":
    # df = pd.read_csv("epa_air_quality_annual_summary.csv", usecols=[
    #  'state_name', 'city_name', 'county_name', 'year', 'observation_percent'])
    if choice == 0:
        state_code(value)
    elif choice == 1:
        city_code(value)
    else:
        county_code(value)
