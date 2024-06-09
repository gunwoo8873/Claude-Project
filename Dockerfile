FROM bash:latest

# PowerShell and Bash for Git and Docker Commands Directory
COPY ./Commands/. .
# The Base the Web and Server for Directory
COPY ./public/. .
COPY ./src/. .

# The Bash and Windows at Git Commands Main run Files
COPY .dockerignore .
COPY Bash_run.sh .
COPY PS_run.ps1 .

CMD [ "executable" ]