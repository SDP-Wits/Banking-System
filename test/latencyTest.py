import multiprocessing
import time
import requests
all_ids = ['37','41','35','41','36','45']
url = 'http://execution-empire.c1.biz/php/select_client_log.php?clientID='
arr = []

for i in range(len(all_ids)):
    arr.append((i,))

def driver_func():
    if __name__ == '__main__':
        PROCESSES = len(all_ids)
        with multiprocessing.Pool(PROCESSES) as pool:
            k = arr
            results= [pool.apply_async(make_request, p) for p in k]

            i = 0
            for r in results:
                print("These are the times taken for client ", all_ids[i] ,':',["{0:.5f}".format(i) for i in r.get()])
                i+=1

def make_request(i):
    all_times = []
    all_responses = []
    for j in range(10):
        start = time.process_time()
        response = requests.get(url+ all_ids[i])
        all_responses.append(response.content)
        request_time = time.process_time() - start
        all_times.append(request_time)
    return  all_times

driver_func()
#this file does the latency test. It makes 10 simultaneous calls to the database from each user, and the wait time was less than
# 0.1 seconds each call - this is a python file, and has to be run independently from the app
