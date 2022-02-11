# pylint: disable=missing-function-docstring, missing-module-docstring, invalid-name, unnecessary-comprehension, wrong-import-position, import-error
import os
import sys
from fastapi import FastAPI
sys.path.insert(0,"..")
# pylint: disable=R0402
import edgar.edgar_downloader as edgar_downloader
import edgar.ref_data as edgar_refdata
# sp100 from the ref_data
df_sp100 = edgar_refdata.get_sp100()
tickers_dict  = df_sp100['Symbol']

# chosen local cached folder
input_folder = r'/tmp/edgar/temp/junk/10k_reports_raw'

app=FastAPI()

@app.get("/")
async def root():
    return {"message": "Edgar api"}

@app.get("/html/{ticker}/{year}")
# pylint: disable=function-redefined
async def root(ticker: str, year:str):
    # change the tickers from a dictionary to a list
    tickers_list=[]
    for i in tickers_dict:
        tickers_list.append(i)
    # error handling of ticker location
    if ticker not in tickers_list:
        return{"Error": f"{ticker} is not a recognised ticker"}
    # error handling of ticker year
    if int(year)> 2021 or int(year)<2000:
        return {"ERROR": f"{year} is an invalid year"}


    # default filename before search is not found
    fileName = "file not found"
    # search the local directory, specified above, for the file specified by API
    html_files = [f for f in os.listdir(input_folder)]
    # default is it is not in the cache until proven it is
    in_file_path = False
    # looking in local cache for matching ticker and year
    for i in html_files:
        if ticker in i and year in i:
            in_file_path = True
            fileName = i
    # if file not cached, it runs the downloader to download the file
    if in_file_path is False:
        edgar_downloader.download_files_10k(ticker, input_folder, year)
        # once downloaded it searches the cached files again to see if ticker is there
        html_files = [f for f in os.listdir(input_folder)]
        for i in html_files:
            if ticker in i and year in i:
                in_file_path = True
                fileName = i

    localUrl = fr'/tmp/edgar/temp/junk/10k_reports_raw/{fileName}'
    # pylint: disable=W1514
    with open(localUrl, 'r') as file:
        fileContents = file.read()

    return{"message": fileContents}


# @app.get("/sentiment/{ticker}/{year}")
# async def root(ticker: str, year: str):
#     return{ticker: "sentiment" + " " + year}

# @app.get("/txt/{ticker}/{year}")
# async def root(ticker: str, year: str):
#     return{ticker: "text file" + " " + year}
