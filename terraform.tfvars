instances = {
  win2016 = {
    ami           = "ami-0696be2e6d8c0e89a"
    instance_type = "t2.large"
    name          = "Win2016"
    env           = "winver16"
  }
  win2019 = {
    ami           = "ami-02f42821304e17830"
    instance_type = "t2.large"
    name          = "Win2019"
    env           = "winver19"
  }
  win2022 = {
    ami           = "ami-04a9b7f1b67bebd6f"
    instance_type = "t2.large"
    name          = "Win2022"
    env           = "winver22"
  }
}

key_name = "vpb-key"
