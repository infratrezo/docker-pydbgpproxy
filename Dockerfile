FROM python:2.7
RUN cd /opt \
    && wget downloads.activestate.com/Komodo/releases/11.1.0/remotedebugging/Komodo-PythonRemoteDebugging-11.1.0-91033-linux-x86_64.tar.gz \
    && tar -xvf Komodo-PythonRemoteDebugging-11.1.0-91033-linux-x86_64.tar.gz \
    && mv Komodo-PythonRemoteDebugging-11.1.0-91033-linux-x86_64 pygdb 

RUN ppath=$(python -c "import sys; print('\n'.join(sys.path))" | grep "site-packages") \
    && ln -s /opt/pygdb/pythonlib/* $ppath/

CMD /opt/pygdb/pydbgpproxy -d ${PHP_HOST}:${PHP_PORT} -i ${DEV_HOST}:${DEV_PORT}
