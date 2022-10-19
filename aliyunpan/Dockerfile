FROM tickstep/aliyunpan-sync:v0.2.2

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

COPY ./env_from_file.sh ./aliyunpan/start_aliyunpan.sh /home/app/

# 运行
ENTRYPOINT ./start_aliyunpan.sh