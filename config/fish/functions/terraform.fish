
function terraform
    set -l tf_cmd $argv[1]
    set -e argv[1]
    switch $tf_cmd
        case init
            command terraform init $argv
        case plan
            command terraform plan $argv
        case apply
            command terraform apply $argv
        case destroy
            command terraform destroy $argv
        case '*'
            command terraform $tf_cmd $argv
    end
end
