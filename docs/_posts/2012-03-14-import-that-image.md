---
title: "Import that Image"
date: "2012-03-14"
tags: 
  - "ec2"
---

I just had to import a VM image onto EC2. Here is how I did it.

- Prepare the Image.
- Install VM API Tools

### Prepare the Image

Someone else did this so I really don't know what it takes. But I do know there are [steps that you need to take](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/VMImportPrerequisites.html).

### Install VM API Tools

1. Setup S3 Bucket
    - Go to S3 and create a new Bucket.
2. Download the API Tools from [Amazon](http://aws.amazon.com/developertools/351)
3. Configure Authentication
    - Follow [these steps](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/using-credentials.html#using-credentials-certificate)
    - Get X.509 Certificate
    - Get Private Key
4. Set Environment Variables. `export JAVA\_HOME /path/to/java export EC2\_HOME path/to/aws/api/tools/ export EC2\_PRIVATE\_KEY=/path/to/ect/pk-EXAMPLE.pem export EC2\_CERT=/path/to/ec2/cert-EXAMPLE.pem export EC2\_URL=https://ec2.us-east-1.amazonaws.com`
5. Set Java Args
    
    - Edit ec2-cmd to include:
    `set EC2\_JVM\_ARGS=-Xms1024m -Xmx2048m`
    
6. Import Image
    
    - Run the ec2-import-instance command `$ ec2-import-instance /path/to/vmimage.vmdk -f VMDK -t m1.large -a x86\_64 -b bucketname -o EXAMPLESECRETE -w EXAMPLEKEY`
    - Write down the import id for later use. See Possible Issues below.
    

That's is how I did it. Of course it wasn't a smooth import. I ran into a few issues.

### Possible Issues

- File Format
    - Issue `ERROR: This file appears to be in RAW or flat-VMDK format. Please check the format parameter and the User Guide for more information.`
    - Solution. Change the file format type to RAW: `ec2-import-instance /path/to/vmimage.vmdk -f RAW -t m1.large -a x86\_64 -b brig -o EXAMPLESECRETE -w EXAMPLEKEY`
- Import Interrupted
    - Issue: For whatever reason the import process is interrupted
    - Solution: Restart the process. The import id is displayed when you start the import process. `$ .ec2-resume-import -t import-i-EXAMPLEID -o EXAMPLESECRETE -w EXAMPLEKEY /path/to/vmimage.vmdk`
- Import Failed
    
    - Issue: Failed due to unsupported OS Type. In my case I tried to upload Win7
    
    Solution: Delete the import process `$ .ec2-cancel-conversion-task import-i-EXAMPLEID`
    

### Resources

- [Setup API Tools](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/setting-up-your-tools.html)
- [Import Command](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/UploadingYourInstancesandVolumes.html)
- [API Operations](http://docs.amazonwebservices.com/AWSEC2/latest/CommandLineReference/OperationList-cmd.html)
