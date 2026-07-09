allprojects {
    repositories {
        google()
        mavenCentral()
        maven(url = "https://storage.googleapis.com/download.flutter.io")
        maven(url = "https://jitpack.io")
    }
    afterEvaluate {
        val paymobProject = rootProject.findProject(":flutter_paymob_sdk")
        if (paymobProject != null) {
            repositories {
                maven {
                    url = uri("${paymobProject.projectDir}/libs")
                }
            }
        }
    }
    
    configurations.all {
        resolutionStrategy {
            eachDependency {
                if (requested.group == "androidx.browser") {
                    useVersion("1.8.0")
                }
                if (requested.group == "androidx.core" && (requested.name == "core" || requested.name == "core-ktx")) {
                    useVersion("1.13.1")
                }
                if (requested.group == "androidx.activity") {
                    useVersion("1.9.3")
                }
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
