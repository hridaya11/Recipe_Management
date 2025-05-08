# Use official Tomcat base image
FROM tomcat:9.0

# Remove default ROOT webapp to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file into Tomcat's webapps directory
# Assuming your WAR file is named recipea_management.war
COPY Recipe_Management.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Tomcat default)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
