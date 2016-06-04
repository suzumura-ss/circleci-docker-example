namespace :eb do
  desc 'package for ElasticBeanstalk-docker'
  task :package, [:zipname] do |t, args|
    version = ENV['APPLICATION_VERSION'] || Time.now.strftime('%Y%m%dT%H%M%S')
    zipname = args[:zipname] || "circleci-docker-example-#{version}.zip"
    sh <<-__script__
      sed -e 's/<APPLICATION_VERSION>/#{version}/' < .ebextensions/20_setversion.config.template > .ebextensions/20_setversion.config
      zip -9r pkg/#{zipname} Dockerfile Dockerrun.aws.json `git ls-files nginx` `git ls-files .ebextensions` .ebextensions/20_setversion.config
    __script__
  end
end
