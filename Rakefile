namespace :eb do
  desc 'package for ElasticBeanstalk-docker'
  task :package, [:zipname] do |t, args|
    zipname = args[:zipname] || "circleci-docker-example-#{Time.now.strftime('%Y%m%dT%H%M%S')}.zip"
    sh <<-__script__
      zip -9r pkg/#{zipname} Dockerfile Dockerrun.aws.json `git ls-files nginx` `git ls-files .ebextensions`
    __script__
  end
end
