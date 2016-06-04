namespace :eb do
  desc 'package for ElasticBeanstalk-docker'
  task :package, [:stamp] do |t, args|
    stamp = args[:stamp] || Time.now.strftime('%Y%m%dT%H%M%S')
    sh <<-__script__
      zip -9r pkg/circleci-docker-example-#{stamp}.zip Dockerfile Dockerrun.aws.json `git ls-files nginx` `git ls-files .ebextensions`
    __script__
  end
end
