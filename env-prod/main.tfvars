env = "prod"
monitor_cidr = ["172.31.86.68/32"]
bastion_cidr = ["172.31.86.68/32"]
default_vpc_id= "vpc-0e91f72112691c58c"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-09c0b52de0b3a5bcf"
kms_arn = "arn:aws:kms:us-east-1:119876270834:key/ca96756f-0bb2-4402-b6ae-7383aa4f1c79"
domain_name = "robog.store"
domain_id = "Z013308937D6QZ0QWCBJ3"
vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets ={
      public = {
        name = "public"
        cidr_block=["10.0.0.0/24","10.0.1.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
      web = {
        name = "web"
        cidr_block=["10.0.2.0/24","10.0.3.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
      app = {
        name = "app"
        cidr_block=["10.0.4.0/24","10.0.5.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
      db = {
        name = "db"
        cidr_block=["10.0.6.0/24","10.0.7.0/24"]
        azs = ["us-east-1a","us-east-1b"]
      }
    }
  }

}

app = {

  frontend = {
    name = "frontend"
    instance_type = "t3.small"
    subnet_name = "web"
    allow_app_cidr = "public"
    desired_capacity   =2
  max_size           = 10
  min_size           = 1
  app_port = 80
  listener_priority = 1 
  lb_type = "public"
  dns_name = "www"
  parameters =[]
  }
   catalogue = {
    name = "catalogue"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
     desired_capacity   = 2
  max_size           = 10
  min_size           = 1
  app_port= 8080
  listener_priority = 1
  lb_type = "private"
  parameters = ["docdb"]
  
  }


    user = {
    name = "user"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
     desired_capacity   = 2
  max_size           = 10
  min_size           = 1
  app_port= 8080
  listener_priority = 2
  lb_type = "private"
  parameters = ["docdb"]
  
  }


 cart = {
    name = "cart"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
     desired_capacity   = 2
  max_size           = 10
  min_size           = 1
  app_port= 8080
  listener_priority = 3
  lb_type = "private"
  parameters = []
  
  }

   shipping = {
    name = "shipping"
    instance_type = "t3.medium"
    subnet_name = "app"
    allow_app_cidr = "app"
     desired_capacity   = 4
  max_size           = 10
  min_size           = 4
  app_port= 8080
  listener_priority = 4
  lb_type = "private"
  parameters = ["rds"]
  
  }

   payment = {
    name = "payment"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "app"
     desired_capacity   = 2
  max_size           = 10
  min_size           = 1
  app_port= 8080
  listener_priority = 5
  lb_type = "private"
  parameters = []
  
  }
 
}

 docdb = {
    main = {
        subnet_name = "db"
        allow_db_cidr = "app"
        engine_version = "4.0.0"
        instance_count = 1
        instance_class = "db.t3.medium"
    }
  }

 rds = {
    main = {
        subnet_name = "db"
        allow_db_cidr = "app"
        engine_version = "5.7.mysql_aurora.2.11.2"
        instance_count = 1
        instance_class = "db.t3.small"
    }
  }

elasticache = {
    main = {
        subnet_name = "db"
        allow_db_cidr = "app"
        engine_version = "6.x"
        replicas_per_node_group = 1
        num_node_groups = 1 
        node_type = "cache.t3.micro"
        num_cache_nodes = 1
    }
  }

  rabbitmq = {
    main = {
        subnet_name = "db"
        allow_db_cidr = "app"
       instance_type = "t3.small"
    }
  }

  alb = {
    public = {
      name = "public"
      subnet_name = "public"
      allow_alb_cidr = "public"
      internal = false

    }
    private = {
      name = "private"
      subnet_name = "app"
      allow_alb_cidr = "web"
      internal = true

    }
  }



