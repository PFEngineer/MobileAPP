allprojects {
    repositories {
        google()
        mavenCentral()
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

// Alinha o JVM target de Java e Kotlin em todos os subprojetos. Plugins de
// terceiros (ex.: amplitude_flutter) fixam o Kotlin em 1.8 enquanto o Java fica
// em 11, o que quebra o build com "Inconsistent JVM-target compatibility".
// Forçamos os dois para 17 (igual ao :app). Roda em projectsEvaluated para
// sobrepor a configuração feita pelos próprios plugins.
gradle.projectsEvaluated {
    subprojects {
        tasks.withType<JavaCompile>().configureEach {
            sourceCompatibility = JavaVersion.VERSION_17.toString()
            targetCompatibility = JavaVersion.VERSION_17.toString()
        }
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            compilerOptions {
                jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
