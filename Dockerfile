FROM ubuntu:latest

WORKDIR /FP1-1-Project .

# PowerShell and Bash for Git and Docker Commands Directory
COPY /Commands/. .
COPY /FP1-1-Project/. .

# The Bash and Windows at Git Commands Main run Files
COPY Bash_run.sh .
COPY PowerShell_run.ps1 .

CMD [ "executable" ]