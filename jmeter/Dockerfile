FROM hauptmedia/jmeter
ADD blog-test-plan.jmx /tmp/blog-test-plan.jmx
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["start-service"]