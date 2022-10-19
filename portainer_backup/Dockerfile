FROM savagesoftware/portainer-backup:latest

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

COPY ./env_from_file.sh ./portainer_backup/start_portainer_backup.sh /usr/local/bin/

# NODEJS RUNNING THIS APPLICATION IS THE ENTRYPOINT
ENTRYPOINT [ "/usr/local/bin/start_portainer_backup.sh" ]

# DEFAULT COMMAND (if none provided)
CMD ["schedule"]