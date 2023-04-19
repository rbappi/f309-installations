#!/usr/bin/python

import copy

AGENT = f"""
        kerberos-agent1:
            image: "kerberos/agent:latest"
            ports:
            - ""
            environment:
            - AGENT_NAME=
            - AGENT_USERNAME=
            - AGENT_PASSWORD=
            - AGENT_HUB_KEY=
            - AGENT_HUB_PRIVATE_KEY=
            - AGENT_HUB_USERNAME=
        """


def generate_yaml_file():
    nmbr_of_agent = 0
    username = ""
    password = ""
    hub_key = ""
    hub_private_key = ""
    hub_username = ""
    agents_to_create = []
    while nmbr_of_agent == 0:
        print("How many agents do you want to create ? (max 20)")
        nmbr_of_agent = input()
        if int(nmbr_of_agent) == 0:
            print("Your input must be at least 1")

    print("What username do you wish to have to login to your agents")
    username = input()
    if username == "":
        username = "root"
    print(f"Your username is {username}")
    print("What password do you wish to have to login to your agents")
    password = input()
    if password == "":
        password = "root"
    print(f"Your password is {password}")
    while hub_key == "":
        print("What is your hub public key ?")
        hub_key = input()
        if hub_key == "":
            print("Your hub key must not be empty")
            print("You can find it in your profile -> Active Plan -> Public Key")
    print(f"Your hub key is {hub_key}")
    while hub_private_key == "":
        print("What is your hub private key ?")
        hub_private_key = input()
        if hub_private_key == "":
            print("Your hub private key must not be empty")
            print("You can find it in your profile -> Active Plan -> Private Key")
    print(f"Your hub private key is {hub_private_key}")
    while hub_username == "":
        print("What is your hub username ?")
        hub_username = input()
        if hub_username == "":
            print("Your hub username must not be empty")
            print("It's the username you use to login to your Kerberos Hub")
    print(f"Your hub username is {hub_username}")

    for i in range(int(nmbr_of_agent)):
        agent = copy.deepcopy(AGENT)
        agent = agent.replace("ports:\n            - \"\"", f"ports:\n            - \"{8081+i}:80\"" )
        agent = agent.replace("kerberos-agent1", f"kerberos-agent{i+1}")
        agent = agent.replace("AGENT_NAME=", f"AGENT_NAME=kerberos-agent{i+1}")
        agent = agent.replace("AGENT_USERNAME=", f"AGENT_USERNAME={username}")
        agent = agent.replace("AGENT_PASSWORD=", f"AGENT_PASSWORD={password}")
        agent = agent.replace("AGENT_HUB_KEY=", f"AGENT_HUB_KEY={hub_key}")
        agent = agent.replace("AGENT_HUB_PRIVATE_KEY=", f"AGENT_HUB_PRIVATE_KEY={hub_private_key}")
        agent = agent.replace("AGENT_HUB_USERNAME=", f"AGENT_HUB_USERNAME={hub_username}")
        agents_to_create += [agent]

    with open("docker-compose.yml", "w") as f:
        f.write("version: '3.7'\n")
        f.write("services:\n")
        for agent in agents_to_create:
            f.write(agent)





if __name__ == "__main__":
    generate_yaml_file()
