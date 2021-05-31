import multiprocessing
import time
import requests
all_ids = ['0011447788552','0005270104070','8888888844444','3322119988770','6655443322110','9876543210123','0123456789987','9988776655443','0011223344556']
url = 'http://execution-empire.c1.biz/php/select_client_log.php?clientID=$'
arr = []

for i in range(len(all_ids)):
    arr.append((i,))

def driver_func():
    if __name__ == '__main__':
        PROCESSES = len(all_ids)
        with multiprocessing.Pool(PROCESSES) as pool:
            k = arr
            results = [pool.apply_async(make_request, p) for p in k]

            for r in results:
                print('\t', r.get())

def make_request(i):
    all_times = []
    for j in range(10):
        start = time.process_time()
        response = requests.get(url+ all_ids[i])
        request_time = time.process_time() - start
        all_times.append(request_time)
    return all_times
    # print("Request completed in {0:.0f}ms".format(request_time))

driver_func()